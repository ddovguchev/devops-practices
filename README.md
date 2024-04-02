<details>
<summary>Task13. Terraform</summary>

Поднять в aws с помощью terraform следующее: весь VPC (public и private subnet), 2 servers ( bastion host and private), security groups, RDS. Использовать модули. Разобраться как взаимодействуют между собой `variables.tf` и `output.tf` в модулях.

## Доп требования:

### Bastion host:

1. SG дает конект только на 22 порт.
2. С бастиона должна быть возможность достучаться курлом до nginx на приватном серваке (nginx дефолтный на 80 порту).
3. С бастиона не должно быть возможности достучаться до БД (команда `nc -zv <db_host> <db_port>` должна вернуть **fail**)
Private host:
4. Sg доступ к nginx и ssh.
5. Должен мочь с бастиона законектиться ssh-джампом на приватный сервак.
6. Должна быть возможность подключиться к бд (команда `nc -zv <db_host> <db_port>` должна вернуть success)

### Модули:
1. использованы variables, outputs, locals(где возможно).
2. реализованы модули ec2, rds, vpc. Насколько можно параметризированы они.  3*. Модуль ec2: Должен из вызова модуля создавать для своих серверов и sg, и ebs диск, и ec2. Должен включать переменную servers, которая выступает листом объектов с конфигом серверов. Т.е ес2 модуль должен мочь создавать из этого параметра одним инклюдом модуля несколько серверов (нужно будет использовать for_each, dynamic и for expressions). 

<b>Прим. структуры:</b>
```javascript
servers_config = {
 "server_name1" = { 
    sg_config = {
      <sg_config>
    }
  <server_config>
  },
 "server_name2" = { 
    sg_config = {
      <sg_config>
    }
  <server_config>
  },  
}.  
```
Где, конфиги - тобой определенные параметры объекта server sg_config
</details>

[Solution](https://github.com/ddovguchev/devops-practices/tree/master/Task13.%20Terraform/task_solution)
