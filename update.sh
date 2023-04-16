source ./PKGBUILD
echo "Curr ver - v"$pkgver
echo "Enter new ver:"
read newver
sed -i "s|$pkgver|$newver|g" PKGBUILD

git add .
git commit -m v$newver
git tag v$newver
git push
git push origin --tags

makepkg -sfri

echo 'Publishing package to FMNX, enter creds.'
echo 'Enter separated by space'
read username password
echo $username
echo $password

filename=fmnx-install-$newver-$newver-x86_64.pkg.tar.zst

