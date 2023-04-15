source ./PKGBUILD
echo "Curr ver - v"$pkgver
echo "Enter new ver:"
read newver
sed -i "s|$pkgver|$newver|g" PKGBUILD

git add .
git commit -m $newver
git tag -a $newver
git push

fmnx-install-v0.2.tar.gz