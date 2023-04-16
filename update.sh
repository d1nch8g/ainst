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
sha1sum  $tarsum > tmpsum
sed -i 's|  fmnx-install.sh||g' tmpsum
sed -i 's|\r\n||g' tmpsum
newsum=$(cat tmpsum)
rm tmpsum

sed -i "s|$sha1sums|$newsum|g"

git add .
git commit -m v$newver
git tag v$newver
git push
git push origin --tags

makepkg -sfri