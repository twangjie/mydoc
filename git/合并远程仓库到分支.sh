# 用于将现有的仓库合并到新仓库的子目录中

NEW_REPO=springframework

mkdir $NEW_REPO
cd $NEW_REPO
git init

PRJNAME=webtelnet
git remote add -f $PRJNAME https://github.com/twangjie/$PRJNAME
git merge -s ours --no-commit --allow-unrelated-histories $PRJNAME/master
git read-tree --prefix=$PRJNAME/ -u $PRJNAME/master
git commit -m "Subtree merged in $PRJNAME"

# push到github
git remote add origin https://github.com/twangjie/$NEW_REPO.git
git push -u origin master -v --progress

