@echo off
echo Setting up Git repository...

git config --global user.name "xmyocat"
git config --global user.email "xmyocat@gmail.com"
echo Git identity configured

git init
echo Git repository initialized

git remote add origin https://github.com/xmyocat/pixel-art-generator.git
echo Remote repository connected

git add .
echo Files staged for commit

git commit -m "Initial commit with pixel art generator app"
echo Files committed

git push -u origin main
echo Pushed to GitHub

echo All done! If you were prompted for credentials, make sure to use a Personal Access Token as your password.
echo If you got an error about main vs master branch, try running: git push -u origin master