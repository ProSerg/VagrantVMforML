1. Установить VirtualBox
https://www.virtualbox.org/wiki/Download_Old_Builds_5_2

2. Установить vagrant
https://www.vagrantup.com/downloads.html

3. Добавить в PATH vagrant.exe

4. В рабочую директорию скачать данные исходники из https://github.com/ProSerg/VagrantVMforML

5. Через командую строку cmd зайти в рабочую диреткорию.

6. выполнить комманды

```
vagrant init ubuntu/xenial64
vagrant plugin install vagrant-disksize
vagrant up
```

Чтобы обновить , добавить пакеты. Нужно добавить в requitements.txt или прописать установку в файл setup.sh.
А чтобы jupyter подхватил новые пакеты слеудет его перезапустить.
Можно перезапустить VM что долго. 
Можно перезапустить jupyter в ручную, что сложно. Это делаеться следующей командой

```
vagrant ssh
sudo systemctl restart jupyter.service
```

7. Дождаться выполнение комманды. Затема через браузер зайти по адрессу 

http://localhost:8080/?token=sha1:cf2a799f39bc:aad334f602bf3425668db12f7170e8048eac99d6