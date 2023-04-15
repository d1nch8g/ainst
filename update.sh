source ./PKGBUILD
echo "Curr ver - v"$pkgver
echo "Enter new ver:"
read newver
sed -i "s|$pkgver|$newver|g" PKGBUILD

cd ..
tar -czf fmnx-install-v$newver.tar.gz fmnx-install
mv fmnx-install-v$newver.tar.gz fmnx-install
cd fmnx-install

tarsum=$(sha1sum  fmnx-install-v$newver.tar.gz)
echo $tarsum
read tarsum
awk "{ if (NR == 30) print "$tarsum"; else print $0}" PKGBUILD > PKGBUILD

git add .
git commit -m v$newver
git tag v$newver
git push
