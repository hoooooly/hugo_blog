@echo "start push"
git add .

@echo "add commit"

git commit -m %0

git push

@echo "push successful"

@pause
