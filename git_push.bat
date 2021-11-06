@echo "start push"

git add .

@echo "add commit"

git commit -m %1

git push

@echo "push successful"

@pause
