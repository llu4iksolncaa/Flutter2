abstract class DataBaseRequest {
  static String deleteTable(String table) => "DROP TABLE '$table'";

  /// Таблица Роли
  ///
  /// Поля таблицы: Название роли
  static const String tableRole = 'Role';

  /// Таблица Пользователи
  ///
  /// Поля таблицы: ....
  static const String tableUsers = 'Users';

  /// Таблица Поставщики
  static const String tableProviders = 'Providers';

  /// Таблица складов
  static const String tableStocks = 'Stocks';

  /// Таблица категории товаров
  static const String tableProductCategories = 'ProductCategories';

  /// Таблица товаров
  static const String tableProducts = 'Products';

  /// Таблица точек выдачи
  static const String tableIssuePoints = 'IssuePoints';

  /// Таблица прихода товара
  static const String tableArrivals = 'Arrivals';

  /// Таблица расхода товара 
  static const String tableConsumptions = 'Consumptions';

  static const List<String> tableList = [tableRole, tableUsers, tableProviders, tableStocks, tableProductCategories, tableProducts, tableIssuePoints, tableArrivals, tableConsumptions];

  static const List<String> createTableList = [
    _createTableRole,
    _createTableUsers,
    _createTableProviders,
    _createTableStocks,
    _createTableProductCategories,
    _createTableProducts,
    _createTableIssuePoints,
    _createTableArrivals,
    _createTableConsumptions
  ];

  /// Запрос для создания таблицы Role
  static const String _createTableRole =
      'CREATE TABLE "$tableRole" ("id" INTEGER,"role" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  /// Запрос для создания таблицы Users
  static const String _createTableUsers =
      'CREATE TABLE "$tableUsers" ("id" INTEGER,"login" TEXT NOT NULL UNIQUE,"password" TEXT NOT NULL,"roleId" INTEGER NOT NULL, "name" TEXT NOT NULL, "surname" TEXT NOT NULL, "patronymic" TEXT NULL, "phoneNumber" TEXT NOT NULL UNIQUE, "email" TEXT NOT NULL UNIQUE,FOREIGN KEY("roleId") REFERENCES "Role"("id"),PRIMARY KEY("id" AUTOINCREMENT))';

  /// Запрос для создания таблицы Providers
  static const String _createTableProviders = 'CREATE TABLE "$tableProviders" ("id" INTEGER, "name" TEXT NOT NULL, "address" TEXT NOT NULL, "phoneNumber" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  /// Запрос для создания таблицы Stocks
  static const String _createTableStocks = 'CREATE TABLE "$tableStocks" ("id" INTEGER, "address" TEXT NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))';

  /// Запрос для создания таблицы ProductCategories
  static const String _createTableProductCategories = 'CREATE TABLE "$tableProductCategories" ("id" INTEGER, "name" TEXT NOT NULL, "description" TEXT NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))';

  /// Запрос для создания таблицы Products
  static const String _createTableProducts = 'CREATE TABLE "$tableProducts" ("id" INTEGER, "description" TEXT NOT NULL, "price" DOUBLE NOT NULL, "name" TEXT NOT NULL, "exists" BIT(1) NOT NULL, "productCategoryId" INTEGER NOT NULL, "stockId" INTEGER NOT NULL, "count" INTEGER NOT NULL, "vendor" TEXT NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("productCategoryId") REFERENCES "ProductCategories"("id"), FOREIGN KEY("stockId") REFERENCES "Stocks"("id"))';

  /// Запрос для создания таблицы IssuePoints
  static const String _createTableIssuePoints = 'CREATE TABLE "$tableIssuePoints" ("id" INTEGER, "name" TEXT NOT NULL, "address" TEXT NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))';

  /// Запрос для создания таблицы Arrivals
  static const String _createTableArrivals = 'CREATE TABLE "$tableArrivals" ("id" INTEGER, "date" DATETIME NOT NULL, "count" INTEGER NOT NULL, "providerId" INTEGER NOT NULL, "productId" INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("providerId") REFERENCES Providers("id"), FOREIGN KEY("productId") REFERENCES Products("id"))';

  /// Запрос для создания таблицы Consumptions
  static const String _createTableConsumptions = 'CREATE TABLE "$tableConsumptions" ("id" INTEGER, "date" DATETIME NOT NULL, "count" INTEGER NOT NULL, "productId" INTEGER NOT NULL, "userId" INTEGER NOT NULL, "issuePointId" INTEGER NOT NULL, "status" TEXT NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("productId") REFERENCES "Products"("id"), FOREIGN KEY("userId") REFERENCES "Users"("id"), FOREIGN KEY("issuePointId") REFERENCES "IssuePoints"("id"))';
}
