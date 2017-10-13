#!/usr/bin/env bash

# copy from impala to kudu
#create table `kudu`.vehicleinfo (Id STRING COMPRESSION LZ4,passDate STRING Encoding PREFIX_ENCODING COMPRESSION LZ4,Plate STRING Encoding PREFIX_ENCODING COMPRESSION LZ4,DeviceUniqueCode STRING Encoding DICT_ENCODING COMPRESSION LZ4,Speed SMALLINT Encoding BIT_SHUFFLE,TimePlate STRING Encoding PREFIX_ENCODING COMPRESSION LZ4,HasPlate TINYINT Encoding BIT_SHUFFLE,PlateColor TINYINT Encoding BIT_SHUFFLE,PlateType TINYINT Encoding BIT_SHUFFLE,PlatePos_Left SMALLINT Encoding BIT_SHUFFLE,PlatePos_Top SMALLINT Encoding BIT_SHUFFLE,PlatePos_Right SMALLINT Encoding BIT_SHUFFLE,PlatePos_Bottom SMALLINT Encoding BIT_SHUFFLE,VehicleModel STRING Encoding DICT_ENCODING COMPRESSION LZ4,VehicleBrand SMALLINT Encoding BIT_SHUFFLE,VehicleSubModel SMALLINT Encoding BIT_SHUFFLE,VehicleType TINYINT Encoding BIT_SHUFFLE,VehiclePos_Left SMALLINT Encoding BIT_SHUFFLE,VehiclePos_Top SMALLINT Encoding BIT_SHUFFLE,VehiclePos_Right SMALLINT Encoding BIT_SHUFFLE,VehiclePos_Bottom SMALLINT Encoding BIT_SHUFFLE,ColorCar_0 SMALLINT Encoding BIT_SHUFFLE,ColorCar_1 SMALLINT Encoding BIT_SHUFFLE,FaceNum TINYINT Encoding BIT_SHUFFLE,FacePos_0_Left SMALLINT Encoding BIT_SHUFFLE,FacePos_0_Top SMALLINT Encoding BIT_SHUFFLE,FacePos_0_Right SMALLINT Encoding BIT_SHUFFLE,FacePos_0_Bottom SMALLINT Encoding BIT_SHUFFLE,FacePos_1_Left SMALLINT Encoding BIT_SHUFFLE,FacePos_1_Top SMALLINT Encoding BIT_SHUFFLE,FacePos_1_Right SMALLINT Encoding BIT_SHUFFLE,FacePos_1_Bottom SMALLINT Encoding BIT_SHUFFLE,HasCarWindows TINYINT Encoding BIT_SHUFFLE,CarWindowsPos_Left SMALLINT Encoding BIT_SHUFFLE,CarWindowsPos_Top SMALLINT Encoding BIT_SHUFFLE,CarWindowsPos_Right SMALLINT Encoding BIT_SHUFFLE,CarWindowsPos_Bottom SMALLINT Encoding BIT_SHUFFLE,YearLogoNum TINYINT Encoding BIT_SHUFFLE,YearLogo_0_Type SMALLINT Encoding BIT_SHUFFLE,YearLogo_0_Left SMALLINT Encoding BIT_SHUFFLE,YearLogo_0_Top SMALLINT Encoding BIT_SHUFFLE,YearLogo_0_Right SMALLINT Encoding BIT_SHUFFLE,YearLogo_0_Bottom SMALLINT Encoding BIT_SHUFFLE,YearLogo_1_Type SMALLINT Encoding BIT_SHUFFLE,YearLogo_1_Left SMALLINT Encoding BIT_SHUFFLE,YearLogo_1_Top SMALLINT Encoding BIT_SHUFFLE,YearLogo_1_Right SMALLINT Encoding BIT_SHUFFLE,YearLogo_1_Bottom SMALLINT Encoding BIT_SHUFFLE,YearLogo_2_Type SMALLINT Encoding BIT_SHUFFLE,YearLogo_2_Left SMALLINT Encoding BIT_SHUFFLE,YearLogo_2_Top SMALLINT Encoding BIT_SHUFFLE,YearLogo_2_Right SMALLINT Encoding BIT_SHUFFLE,YearLogo_2_Bottom SMALLINT Encoding BIT_SHUFFLE,YearLogo_3_Type SMALLINT Encoding BIT_SHUFFLE,YearLogo_3_Left SMALLINT Encoding BIT_SHUFFLE,YearLogo_3_Top SMALLINT Encoding BIT_SHUFFLE,YearLogo_3_Right SMALLINT Encoding BIT_SHUFFLE,YearLogo_3_Bottom SMALLINT Encoding BIT_SHUFFLE,YearLogo_4_Type SMALLINT Encoding BIT_SHUFFLE,YearLogo_4_Left SMALLINT Encoding BIT_SHUFFLE,YearLogo_4_Top SMALLINT Encoding BIT_SHUFFLE,YearLogo_4_Right SMALLINT Encoding BIT_SHUFFLE,YearLogo_4_Bottom SMALLINT Encoding BIT_SHUFFLE,SunVisorNum TINYINT Encoding BIT_SHUFFLE,SunVisorPos_0_Left SMALLINT Encoding BIT_SHUFFLE,SunVisorPos_0_Top SMALLINT Encoding BIT_SHUFFLE,SunVisorPos_0_Right SMALLINT Encoding BIT_SHUFFLE,SunVisorPos_0_Bottom SMALLINT Encoding BIT_SHUFFLE,SunVisorPos_1_Left SMALLINT Encoding BIT_SHUFFLE,SunVisorPos_1_Top SMALLINT Encoding BIT_SHUFFLE,SunVisorPos_1_Right SMALLINT Encoding BIT_SHUFFLE,SunVisorPos_1_Bottom SMALLINT Encoding BIT_SHUFFLE,HasCarPendant TINYINT Encoding BIT_SHUFFLE,CarPendantPos_Left SMALLINT Encoding BIT_SHUFFLE,CarPendantPos_Top SMALLINT Encoding BIT_SHUFFLE,CarPendantPos_Right SMALLINT Encoding BIT_SHUFFLE,CarPendantPos_Bottom SMALLINT Encoding BIT_SHUFFLE,HasDecoration TINYINT Encoding BIT_SHUFFLE,DecorationPos_Left SMALLINT Encoding BIT_SHUFFLE,DecorationPos_Top SMALLINT Encoding BIT_SHUFFLE,DecorationPos_Right SMALLINT Encoding BIT_SHUFFLE,DecorationPos_Bottom SMALLINT Encoding BIT_SHUFFLE,HasMainDriver TINYINT Encoding BIT_SHUFFLE,MainDriverPos_Left SMALLINT Encoding BIT_SHUFFLE,MainDriverPos_Top SMALLINT Encoding BIT_SHUFFLE,MainDriverPos_Right SMALLINT Encoding BIT_SHUFFLE,MainDriverPos_Bottom SMALLINT Encoding BIT_SHUFFLE,MainSafetyBelt TINYINT Encoding BIT_SHUFFLE,HasViceDriver TINYINT Encoding BIT_SHUFFLE,ViceDriverPos_Left SMALLINT Encoding BIT_SHUFFLE,ViceDriverPos_Top SMALLINT Encoding BIT_SHUFFLE,ViceDriverPos_Right SMALLINT Encoding BIT_SHUFFLE,ViceDriverPos_Bottom SMALLINT Encoding BIT_SHUFFLE,ViceSafetyBelt TINYINT Encoding BIT_SHUFFLE,ImageSize INT Encoding BIT_SHUFFLE, PRIMARY KEY(id,passdate,plate,DeviceUniqueCode)) PARTITION BY HASH(passdate) PARTITIONS 4,HASH(Plate) PARTITIONS 4,HASH(DeviceUniqueCode) PARTITIONS 4 STORED AS KUDU TBLPROPERTIES( 'kudu.table_name' = 'vehicleinfo','kudu.master_addresses' = 'host02:7051,host03:7051,host04:7051');

# copy from kudu to impala
# insert overwrite tip.vehicleinfo partition(passdate) select id,speed,timeplate,hasplate,plate,platecolor,platetype,platepos_left,platepos_top,platepos_right,platepos_bottom,vehiclemodel,vehiclebrand,vehiclesubmodel,vehicletype,vehiclepos_left,vehiclepos_top,vehiclepos_right,vehiclepos_bottom,colorcar_0,colorcar_1,facenum,facepos_0_left,facepos_0_top,facepos_0_right,facepos_0_bottom,facepos_1_left,facepos_1_top,facepos_1_right,facepos_1_bottom,hascarwindows,carwindowspos_left,carwindowspos_top,carwindowspos_right,carwindowspos_bottom,yearlogonum,yearlogo_0_type,yearlogo_0_left,yearlogo_0_top,yearlogo_0_right,yearlogo_0_bottom,yearlogo_1_type,yearlogo_1_left,yearlogo_1_top,yearlogo_1_right,yearlogo_1_bottom,yearlogo_2_type,yearlogo_2_left,yearlogo_2_top,yearlogo_2_right,yearlogo_2_bottom,yearlogo_3_type,yearlogo_3_left,yearlogo_3_top,yearlogo_3_right,yearlogo_3_bottom,yearlogo_4_type,yearlogo_4_left,yearlogo_4_top,yearlogo_4_right,yearlogo_4_bottom,sunvisornum,sunvisorpos_0_left,sunvisorpos_0_top,sunvisorpos_0_right,sunvisorpos_0_bottom,sunvisorpos_1_left,sunvisorpos_1_top,sunvisorpos_1_right,sunvisorpos_1_bottom,hascarpendant,carpendantpos_left,carpendantpos_top,carpendantpos_right,carpendantpos_bottom,hasdecoration,decorationpos_left,decorationpos_top,decorationpos_right,decorationpos_bottom,hasmaindriver,maindriverpos_left,maindriverpos_top,maindriverpos_right,maindriverpos_bottom,mainsafetybelt,hasvicedriver,vicedriverpos_left,vicedriverpos_top,vicedriverpos_right,vicedriverpos_bottom,vicesafetybelt,imagesize,deviceuniquecode,passdate from `kudu`.vehicleinfo where passdate='2017-09-13';

date1="$1"
date2="$2"
step=5

if [ -n "$3" ]; then
    step=$3
fi

#echo "date1: $date1"
#echo "date2: $date2"
tempdate=`date -d "-0 day $date1" +%F`
enddate=`date -d "-0 day $date2" +%F`
tempdateSec=`date -d "-0 day $date1" +%s`
enddateSec=`date -d "-0 day $date2" +%s`
echo "####################################"
echo 'tempdate: '$tempdate
echo 'enddate: '$enddate
echo 'step: '$step
echo "####################################"

for i in `seq 1 $step 10000`; do
    if [[ $tempdateSec -gt $enddateSec ]]; then
        break
    fi

    nextdate=`date -d "+$i day $date1" +%F`
    nextdateSec=`date -d "+$i day $date1" +%s`
    
    if [[ $nextdateSec -gt $enddateSec ]]; then
        nextdate=$enddate
    fi
    
    echo ""
    echo "################################################################"
    echo 'passdate>='$tempdate' and passdate<'$nextdate
    echo "################################################################"
    
    sql="insert into \`kudu\`.vehicleinfo select Id,passdate,IFNULL(Plate, '未识别'),DeviceUniqueCode,cast(Speed as smallint),TimePlate,cast(HasPlate as tinyint),cast(PlateColor as tinyint),cast(PlateType as tinyint),cast(PlatePos_Left as smallint),cast(PlatePos_Top as smallint),cast(PlatePos_Right as smallint),cast(PlatePos_Bottom as smallint),VehicleModel,cast(VehicleBrand as smallint),cast(VehicleSubModel as smallint),cast(VehicleType as tinyint),cast(VehiclePos_Left as smallint),cast(VehiclePos_Top as smallint),cast(VehiclePos_Right as smallint),cast(VehiclePos_Bottom as smallint),cast(ColorCar_0 as smallint),cast(ColorCar_1 as smallint),cast(FaceNum as tinyint),cast(FacePos_0_Left as smallint),cast(FacePos_0_Top as smallint),cast(FacePos_0_Right as smallint),cast(FacePos_0_Bottom as smallint),cast(FacePos_1_Left as smallint),cast(FacePos_1_Top as smallint),cast(FacePos_1_Right as smallint),cast(FacePos_1_Bottom as smallint),cast(HasCarWindows as tinyint),cast(CarWindowsPos_Left as smallint),cast(CarWindowsPos_Top as smallint),cast(CarWindowsPos_Right as smallint),cast(CarWindowsPos_Bottom as smallint),cast(YearLogoNum as tinyint),cast(YearLogo_0_Type as smallint),cast(YearLogo_0_Left as smallint),cast(YearLogo_0_Top as smallint),cast(YearLogo_0_Right as smallint),cast(YearLogo_0_Bottom as smallint),cast(YearLogo_1_Type as smallint),cast(YearLogo_1_Left as smallint),cast(YearLogo_1_Top as smallint),cast(YearLogo_1_Right as smallint),cast(YearLogo_1_Bottom as smallint),cast(YearLogo_2_Type as smallint),cast(YearLogo_2_Left as smallint),cast(YearLogo_2_Top as smallint),cast(YearLogo_2_Right as smallint),cast(YearLogo_2_Bottom as smallint),cast(YearLogo_3_Type as smallint),cast(YearLogo_3_Left as smallint),cast(YearLogo_3_Top as smallint),cast(YearLogo_3_Right as smallint),cast(YearLogo_3_Bottom as smallint),cast(YearLogo_4_Type as smallint),cast(YearLogo_4_Left as smallint),cast(YearLogo_4_Top as smallint),cast(YearLogo_4_Right as smallint),cast(YearLogo_4_Bottom as smallint),cast(SunVisorNum as tinyint),cast(SunVisorPos_0_Left as smallint),cast(SunVisorPos_0_Top as smallint),cast(SunVisorPos_0_Right as smallint),cast(SunVisorPos_0_Bottom as smallint),cast(SunVisorPos_1_Left as smallint),cast(SunVisorPos_1_Top as smallint),cast(SunVisorPos_1_Right as smallint),cast(SunVisorPos_1_Bottom as smallint),cast(HasCarPendant as tinyint),cast(CarPendantPos_Left as smallint),cast(CarPendantPos_Top as smallint),cast(CarPendantPos_Right as smallint),cast(CarPendantPos_Bottom as smallint),cast(HasDecoration as tinyint),cast(DecorationPos_Left as smallint),cast(DecorationPos_Top as smallint),cast(DecorationPos_Right as smallint),cast(DecorationPos_Bottom as smallint),cast(HasMainDriver as tinyint),cast(MainDriverPos_Left as smallint),cast(MainDriverPos_Top as smallint),cast(MainDriverPos_Right as smallint),cast(MainDriverPos_Bottom as smallint),cast(MainSafetyBelt as tinyint),cast(HasViceDriver as tinyint),cast(ViceDriverPos_Left as smallint),cast(ViceDriverPos_Top as smallint),cast(ViceDriverPos_Right as smallint),cast(ViceDriverPos_Bottom as smallint),cast(ViceSafetyBelt as tinyint),cast(ImageSize as int) from tip.vehicleinfo where passdate>='"$tempdate"' and passdate<'$nextdate';summary;"
    
    #echo "$sql"
    impala-shell -q "$sql"

    tempdateSec=$nextdateSec
    tempdate=$nextdate

done
