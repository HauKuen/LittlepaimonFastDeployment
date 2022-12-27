echo '开始搭配环境'
echo '开始更新源'
sudo apt update && sudo apt upgrade -y
echo '更新结束'

echo "开始安装git"
sudo apt install git -y
echo "git安装完成"

echo "开始安装ffmpeg"
sudo apt install ffmpeg -y
echo "ffmpeg安装完成"

echo "开始安装poetry"
pip install poetry
echo "poetry安装完成"


if [ ! -d LittlePaimon/ ]; then
    echo "开始克隆小派蒙"
    git clone --depth=1 https://github.com/CMHopeSunshine/LittlePaimon
    if [ ! -d LittlePaimon/ ]; then
        echo "正在切换Gitee下载"
        git clone --depth=1 https://gitee.com/CherishMoon/LittlePaimon
        if [ ! -d LittlePaimon/ ]; then
            echo "小派蒙克隆失败"
            exit
        else
            echo "小派蒙克隆成功"
        fi
    fi
fi

echo "开始安装依赖"
cd LittlePaimon/
poetry install
echo "依赖安装完成"

echo "安装go-cqhttp插件"
poetry run nb plugin install nonebot-plugin-gocqhttp
echo "go-cqhttp插件安装完成"

echo "请输入Bot管理员的QQ号: "
read new_value
sed -i "s/\(SUPERUSERS=\[\"\)[^\"]*\(\"\]\)/\1$new_value\2/" .env.prod
echo "Bot管理员QQ号已设置为$new_value"

echo "已部署成功,输入cd LittlePaimon进入目录,运行poetry run python bot.py启动Bot"
echo "访问http://127.0.0.1:13579/go-cqhttp来添加Bot账号，添加完成后需重启Bot"
echo "访问http://127.0.0.1:13579/LittlePaimon/login来管理Bot