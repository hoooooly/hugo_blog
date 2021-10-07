:: 检测环境
:: tcb hosting detail -e blog-1gfz2hntbae53791



:: 生成部署文件
hugo

:: 删除托管环境下所有文件然后部署
tcb hosting delete / -e blog-1gfz2hntbae53791 && tcb hosting deploy ./public/ / -e blog-1gfz2hntbae53791

echo "上传成功，部署完成！"

pause