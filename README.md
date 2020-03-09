# Структура репозитория.
- `coppeliasim/` - папка содержащая сцены и неоходимые для запуска сцены скрипты.
- `rviz/` - папка содержащая конфиг для rviz.
- `scripts/` - папка содержащая скрипты которые "вешаются" на Lidar и на тело робота. (Они уже встроены в сцену, их не надо вешать самому. Они лежат тут что бы можно было просмотреть скрипты без запуска сцены.


# Инструкция по установки [`Coppeliasim`](https://coppeliarobotics.com/ubuntuVersions) и [`ROS`](http://wiki.ros.org/melodic/Installation/Ubuntu) 
## Установка ROS (Melodic)
- Впервую очередь необходимо установить и настроить ROS. [Тут](http://wiki.ros.org/melodic/Installation/Ubuntu) есть подробная иструкция по установке и настройке ROS.
- При выборе версии ROS, выбрать желательно `Desktop-Full Install: (Recommended) `, что бы установить все пакеты
- После установки желательно выполнить шаг `1.6 Environment setup`. Т.к не нужно будет все время настраивать переменные окружения после закрытия консоли.
- После установки ROS желательно проверить работоспособность командой `roscore`, должно высветиться следующее
```
dd@dd-pc:~$ roscore
... logging to /home/dd/.ros/log/55532ab4-53ed-11ea-8956-2cd05aec413a/roslaunch-dd-pc-21482.log
Checking log directory for disk usage. This may take awhile.
Press Ctrl-C to interrupt
Done checking log file disk usage. Usage is <1GB.

started roslaunch server http://dd-pc:38091/
ros_comm version 1.14.3


SUMMARY
========

PARAMETERS
 * /rosdistro: melodic
 * /rosversion: 1.14.3

NODES

auto-starting new master
process[master]: started with pid [21492]
ROS_MASTER_URI=http://dd-pc:11311/

setting /run_id to 55532ab4-53ed-11ea-8956-2cd05aec413a
process[rosout-1]: started with pid [21503]
started core service [/rosout]
```
- Команда `roscore` запускает мастер сервер. Он должен быть всегда запущен когда ведется работа с ROS. 
- Что бы полностью убедиться что все работает нормально, необходимо **не закрывая** мастер сервер, в новой вкладке ввести команду `rostopic list`, должно вывести на консоль следующее. Если все выводится, то все установилось и работает.
```
dd@dd-pc:~$ rostopic list
/rosout
/rosout_agg
```
------
## Установка и запуск Coppeliasim
- Для установки нужно перейти по этой [ссылке](https://coppeliarobotics.com/ubuntuVersions) и выбрать `CoppeliaSim Edu, Ubuntu 18.04`.
- После установки необходимо распаковать в удобное для вас место
- После чего необходимо:
  1. Скопировать содержимое папки `coppeliasim/` в `$_ПАПКА_РАСПАКОВКИ_COPPELIASIM/`. Должно получиться следующая структура
- ![скриншот_1](https://i.imgur.com/4E4UKLu.png?raw=true)
- После чего скачиваем этот [плагин](https://github.com/sfedu-sdbcs/vrep_plugin_velodyne.git) Данный плагин является catkin пакетом. Т.е его нужно собрать ( скомпилировать ). Для этого необходимо инициализировать catkin рабочую директорию и положить скаченный пакет в дирректорию **src/**. Подробней как это делается, описано [тут](http://wiki.ros.org/catkin/Tutorials) (А именно пункты 1 и 3)
- Если "лень" компилировать, в [этом же](https://github.com/sfedu-sdbcs/vrep_plugin_velodyne.git) репозитории, в папке `compiled plugin/` лежит уже скомпилированный файл, но возможно такая ситуация что он не запустится (Coppeliasim будет ругаться), тогда все таки придется скомпилировать плагин самостоятельно. И тогда следующий пункт для вас. 
- После сборки пакета, на выходе должен быть файл **libv_repExtRosVelodyne.so**. По умолчанию он будет храниться **devel/lib/**
- Данный файл (или файл `compiled plugin/libv_repExtRosVelodyne.so` с [этого](https://github.com/sfedu-sdbcs/vrep_plugin_velodyne) репозитория) нужно скопировать в `$_ПАПКА_РАСПАКОВКИ_COPPELIASIM/`
- После чего запускаем среду моделирования `./coppiliaSim.sh`. Перед запуском нужно убедиться что roscore запущен. Иначе плагин не загрузится
- После запуска нажимаем `File -> Open Scene ...` и выбираем сцену которая находится `$_ПАПКА_РАСПАКОВКИ_COPPELIASIM/scenes/user-scenes/nkbvs.ttt`
- После чего сцена должна выглядить следующим образом 
- ![скриншот_2](https://i.imgur.com/0tNJpx2.png?raw=true)
- Далее запускаем симуляцию.
- Чтобы проверить правильно ли все работает, необходимо ввести в коммандной строке `rostopic list` и должно получиться следующее 
```
dd@dd-pc:~$ rostopic list
/clicked_point
/initialpose
/move_base_simple/goal
/rosout
/rosout_agg
/sim_ros_interface/odometry
/tf
/tf_static
/velodyne_points
/vrep_velodyne/odometry

```
- Больше всего нас интересуют
- `/sim_ros_interface/odometry` - Топик в который предается одометрия. Сообщения типа **nav_msgs/Odometry** 
- `/velodyne_points` - Топик в который предается облако точек. Сообщения типа **sensor_msgs/PointCloud2**
## Запуск Rviz
Rviz - программа входящая в состав пакета ROS. Она предназначена для визуализации данных. Для того что бы запустить ее необходимо ввести команду `rviz -d rviz/default.rviz`
- После запуска необходимо что во вкладке PointCloud2 поле **Topic** равен **/velodyne_points**
- А в вкладке Odometry поле **Topic** равен **/sim_ros_interface/odometry**
- После чего начнется отображения облако точек
- ![скриншот_3](https://i.imgur.com/zUOtcM3.png?raw=true)
