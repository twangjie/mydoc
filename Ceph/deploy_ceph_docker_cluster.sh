#!/bin/sh

CEPH_DOCKER_IMAGE="ceph/daemon:tag-build-master-luminous-centos-7"
PUBLIC_NETWORK="192.168.35.0/24"

function init {

    HOST="$1"

    echo "init the host: "$HOST

    ssh root@$HOST 'docker rm -f $(docker ps -a -q -f name=ceph)'

    echo "clean up /opt/docker/ceph";

    ssh root@$HOST 'rm -fr /opt/docker/ceph'

    echo "clean up ceph storages in /data/disks"

    ssh root@$HOST 'rm -fr /data/disks/{1..3}/ceph'

    echo "clean up /data/ramdisk";

    ssh root@$HOST 'umount /data/ramdisk/;mkdir -p /data/ramdisk/'
    ssh root@$HOST 'mount -t tmpfs -o size=3072m tmpfs /data/ramdisk/'
    ssh root@$HOST 'mount |grep /data |grep tmpfs'
}

function deploy_config {

    HOST=$1
    echo "deplay ceph config to "$HOST
    
    retVal=`ip a |grep $HOST |wc -l`
    if [ $retVal == 0 ]; then
        ssh root@$HOST "mkdir -p /opt/docker"
        scp -r /opt/docker/ceph root@$HOST:/opt/docker/
    fi
}

function deploy_mon {

    HOST=$1
    
    echo "init ceph monitor on "$HOST

    retVal=`ip a |grep $HOST |wc -l`
    if [ $retVal == 1 ]; then

        echo "init local monitor"
        
        # 本机
        docker run -d --net=host --name=cephmon -v /opt/docker/ceph/etc/ceph:/etc/ceph -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph -e MON_IP=$HOST -e CEPH_PUBLIC_NETWORK=$PUBLIC_NETWORK $CEPH_DOCKER_IMAGE mon

        sleep 5
        
        # 免认证(luminous v12.1.2 osd_directory需要)
        sed -i 's/cephx/none/g' /opt/docker/ceph/etc/ceph/ceph.conf

        # 修改ceph配置
        echo "mon_allow_pool_delete = true" >> /opt/docker/ceph/etc/ceph/ceph.conf 

        # 修改osd参数
        sed -i '/osd journal size = 100/d' /opt/docker/ceph/etc/ceph/ceph.conf 

        echo "[osd]" >> /opt/docker/ceph/etc/ceph/ceph.conf
        echo "journal aio = false" >> /opt/docker/ceph/etc/ceph/ceph.conf
        echo "journal dio = false" >> /opt/docker/ceph/etc/ceph/ceph.conf
        #echo "osd_pool_erasure_code_stripe_width = 65536" >> /opt/docker/ceph/etc/ceph/ceph.conf
        echo "osd journal size = 1000" >> /opt/docker/ceph/etc/ceph/ceph.conf

        echo "journal_max_write_entries = 1000"  >> /opt/docker/ceph/etc/ceph/ceph.conf
        # 512MB
        echo "journal_max_write_bytes = 536870912"  >> /opt/docker/ceph/etc/ceph/ceph.conf
        echo "journal_queue_max_ops = 5000"  >> /opt/docker/ceph/etc/ceph/ceph.conf
        # 900MB
        echo "journal_queue_max_bytes = 943718400"  >> /opt/docker/ceph/etc/ceph/ceph.conf

        #for ext4 file length bug
        echo "osd_max_object_name_len = 256" >> /opt/docker/ceph/etc/ceph/ceph.conf
        echo "osd_max_object_namespace_len = 64" >> /opt/docker/ceph/etc/ceph/ceph.conf
        echo "osd_check_max_object_name_len_on_startup = false"  >> /opt/docker/ceph/etc/ceph/ceph.conf
        ###

        cat /opt/docker/ceph/etc/ceph/ceph.conf

        sleep 3

        docker restart cephmon
    else
        ssh root@$HOST "docker run -d --net=host --name=cephmon -v /opt/docker/ceph/etc/ceph:/etc/ceph -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph -e MON_IP=$HOST -e CEPH_PUBLIC_NETWORK=$PUBLIC_NETWORK $CEPH_DOCKER_IMAGE mon"
    fi
    
    sleep 3
    
    docker ps -a
}

function deploy_mgr {

    HOST=$1
    echo "init ceph manager on "$HOST

    retVal=`ip a |grep $HOST |wc -l`
    if [ $retVal == 1 ]; then
        docker run -d --net=host --name=cephmgr -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ $CEPH_DOCKER_IMAGE mgr
    else
        ssh root@$HOST "docker run -d --net=host --name=cephmgr -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ $CEPH_DOCKER_IMAGE mgr"
    fi

    sleep 3
    
    docker ps -a 
    docker exec cephmon ceph -s
}

function deploy_osd {

    HOST=$1
    
    echo "init ceph osd on "$HOST

    retVal=`ip a |grep $HOST |wc -l`
    if [ $retVal == 1 ]; then
        
        docker run -d --privileged=true --pid=host --net=host --name=cephosd1 -v /opt/docker/ceph/etc/ceph:/etc/ceph -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -v /dev/:/dev/ -v /data/disks/1/ceph/osd:/var/lib/ceph/osd -v /data/ramdisk:/data/ramdisk -e JOURNAL_DIR=/data/ramdisk $CEPH_DOCKER_IMAGE osd_directory

        #docker run -d --privileged=true --pid=host --net=host --name=cephosd2 -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -v /dev/:/dev/ -v /data/disks/2/ceph/osd:/var/lib/ceph/osd -v /data/ramdisk:/data/ramdisk -e JOURNAL_DIR=/data/ramdisk  $CEPH_DOCKER_IMAGE osd_directory

        docker run -d --privileged=true --pid=host --net=host --name=cephosd3 -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -v /dev/:/dev/ -v /data/disks/3/ceph/osd:/var/lib/ceph/osd -v /data/ramdisk:/data/ramdisk -e JOURNAL_DIR=/data/ramdisk  $CEPH_DOCKER_IMAGE osd_directory
        
    else
        ssh root@$HOST "rm -f /data/ramdisk/*"
        
        ssh root@$HOST "docker run -d --privileged=true --pid=host --net=host --name=cephosd1 -v /opt/docker/ceph/etc/ceph:/etc/ceph -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -v /dev/:/dev/ -v /data/disks/1/ceph/osd:/var/lib/ceph/osd -v /data/ramdisk:/data/ramdisk -e JOURNAL_DIR=/data/ramdisk $CEPH_DOCKER_IMAGE osd_directory"

        #ssh root@$HOST "docker run -d --privileged=true --pid=host --net=host --name=cephosd2 -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -v /dev/:/dev/ -v /data/disks/2/ceph/osd:/var/lib/ceph/osd -v /data/ramdisk:/data/ramdisk -e JOURNAL_DIR=/data/ramdisk  $CEPH_DOCKER_IMAGE osd_directory"

        ssh root@$HOST "docker run -d --privileged=true --pid=host --net=host --name=cephosd3 -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -v /dev/:/dev/ -v /data/disks/3/ceph/osd:/var/lib/ceph/osd -v /data/ramdisk:/data/ramdisk -e JOURNAL_DIR=/data/ramdisk  $CEPH_DOCKER_IMAGE osd_directory"
        
    fi

    sleep 5
    
    docker ps -a
    docker exec cephmon ceph -s
}

function deploy_mds {

    HOST=$1
    
    echo "init ceph mds on "$HOST

    retVal=`ip a |grep $HOST |wc -l`
    if [ $retVal == 1 ]; then
       docker run -d --net=host --name=cephmds -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -e CEPHFS_CREATE=1 $CEPH_DOCKER_IMAGE mds
    else
       ssh root@$HOST "docker run -d --net=host --name=cephmds -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -e CEPHFS_CREATE=1 $CEPH_DOCKER_IMAGE mds"
    fi
}

function deploy_rgw {

    HOST=$1
    
    echo "init ceph rados gateway on "$HOST

    retVal=`ip a |grep $HOST |wc -l`
    if [ $retVal == 1 ]; then
       docker run -d --net=host --name=cephrgw --log-driver=none -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -p 8080:80 $CEPH_DOCKER_IMAGE rgw
    else
       ssh root@$HOST "docker run -d --net=host --name=cephrgw --log-driver=none -v /opt/docker/ceph/etc/ceph:/etc/ceph  -v /opt/docker/ceph/var/lib/ceph/:/var/lib/ceph/ -p 8080:80 $CEPH_DOCKER_IMAGE rgw"
    fi
}

function init_rgw {

    #docker exec cephmon bash -c "ceph osd pool delete default.rgw.meta default.rgw.meta --yes-i-really-really-mean-it;ceph osd pool create default.rgw.meta 32 32;ceph osd pool delete default.rgw.buckets.data default.rgw.buckets.data --yes-i-really-really-mean-it;ceph osd pool create default.rgw.buckets.data 64 64 erasure;ceph osd lspools;ceph df;"

    docker exec -it cephmon bash -c "radosgw-admin user create --display-name=test --uid=test;radosgw-admin subuser create --uid=test --subuser=test:swift --access=full;radosgw-admin key create --subuser=test:swift --key-type=swift --secret=testswift"
}

init 192.168.35.101
init 192.168.35.102
init 192.168.35.103
init 192.168.35.104

deploy_mon 192.168.35.103

deploy_config 192.168.35.101
deploy_config 192.168.35.102
deploy_config 192.168.35.104

deploy_mon 192.168.35.102
deploy_mon 192.168.35.104

deploy_mgr 192.168.35.103

deploy_osd 192.168.35.101
deploy_osd 192.168.35.102
deploy_osd 192.168.35.103
deploy_osd 192.168.35.104

deploy_mds 192.168.35.103

deploy_rgw 192.168.35.101
deploy_rgw 192.168.35.102
deploy_rgw 192.168.35.103
deploy_rgw 192.168.35.104

init_rgw

sleep 5

docker exec cephmon ceph -s
docker exec cephmon ceph osd tree
