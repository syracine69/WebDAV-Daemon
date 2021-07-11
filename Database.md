# Creation of the database
To create the database user, type the following command in a shell

```
$ su - postgres
$ createuser --createdb --login --pwprompt myuser
Enter password for new role:
Enter it again:
exit
```

To create the database, type the following commands in a shell

```
$ createdb -h myowndomain.com -p my_port -U my_user -W  my_database
Password: (type de SQL user password previously created)
```

To create the table, type the following command in a shell

```
psql -h myowndomain.com -p my_port -U my_user -W -d my_database < sql/webdavd.sql
Password: (type de SQL user password previously created)

```

To populate the table of users, type the following command in a shell

```
psql -h myowndomain.com -p my_port -U my_user -W -d my_database -c "INSERT INTO users(username, password, created_on) VALUES ('username', md5('password'), now())"
Password: (type de SQL user password previously created)
INSERT 0 1
```

Note that you have to encrypt with md5 SQL function the password to enable the authentication of the username with webdav-daemon-pgsql.

