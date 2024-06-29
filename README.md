Calculator
=====

An OTP application

Build
-----

    $ rebar3 compile

Build with tests
-----

    $ rebar3 as test compile
    $ rebar3 as test shell
    $ eunit:test([{application, calculator}]).


Run tests
-----
    $ rebar3 compile
    $ rebar3 eunit


Task
-----

* Написать сервер, обслуживающий подключения на вычисления
```
server:connect() -> Pid.
server:calculate (Pid, {add, [1, 2, 3.06, -1]}) -> {ok, 5.06}.
```
* Продемонстрировать параллельность подключений
* Продемонстрировать обработку ошибок
```
server:calculate (Pid, {div, [1, 0]}) -> {error, division_by_zero}.
```
* Со звездочкой
```
server:calculate (Pid, add, [1, {div, [2, {sub, [5, 5]]}) -> {error, division_by_zero}.
```
* Имплементация через gen_server/supervisor/application