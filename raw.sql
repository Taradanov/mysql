/*
1. МАГАЗИН. БД предполагает хранение информации о товаре, остатках товара, заказах клиентов, задолженности клиентов
Таблицы:
    Блок Номенклатура:
    1. Номенклатура
    2. Вид номенклатуры - предполагается что номенклатура обязательно имеет определенный вид, а вид номенклатуры имеет
        уникальные характеристики, например: блоки питания: Мощность, процессоры: производитель, тактовая частота, ядра
    3. Характеристики вида номенклатуры
    4. Значения характеристик номенклатуры - перечень значений для конкретной номенклатурной позиции

    Блок Склад:
    1. Склады.
    2. Остатки Номенклатуры.

    Блок Клиенты
    1. Заказы клиентов.
    2. Табличная часть заказа
    3. Задолженность клиента

    Блок логгирование
    1. Лог файл.
 */