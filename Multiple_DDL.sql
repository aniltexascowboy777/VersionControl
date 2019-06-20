CREATE TABLE [Application].[DeliveryMethods]  ( 
    [DeliveryMethodID]  	int NOT NULL CONSTRAINT [DF_Application_DeliveryMethods_DeliveryMethodID]  DEFAULT (NEXT VALUE FOR [Sequences].[DeliveryMethodID]),
    [DeliveryMethodName]	nvarchar(50) NOT NULL,
    [LastEditedBy]      	int NOT NULL,
    [ValidFrom]         	datetime2 NOT NULL,
    [ValidTo]           	datetime2 NOT NULL,
    CONSTRAINT [PK_Application_DeliveryMethods] PRIMARY KEY CLUSTERED([DeliveryMethodID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Application].[DeliveryMethods]
    ADD CONSTRAINT [UQ_Application_DeliveryMethods_DeliveryMethodName]
	UNIQUE ([DeliveryMethodName])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
ALTER TABLE [Application].[DeliveryMethods]
    ADD CONSTRAINT [FK_Application_DeliveryMethods_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE TABLE [Application].[DeliveryMethods_Archive]  ( 
    [DeliveryMethodID]  	int NOT NULL,
    [DeliveryMethodName]	nvarchar(50) NOT NULL,
    [LastEditedBy]      	int NOT NULL,
    [ValidFrom]         	datetime2 NOT NULL,
    [ValidTo]           	datetime2 NOT NULL 
    )
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_DeliveryMethods_Archive]
    ON [Application].[DeliveryMethods_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
CREATE TABLE [Application].[PaymentMethods]  ( 
    [PaymentMethodID]  	int NOT NULL CONSTRAINT [DF_Application_PaymentMethods_PaymentMethodID]  DEFAULT (NEXT VALUE FOR [Sequences].[PaymentMethodID]),
    [PaymentMethodName]	nvarchar(50) NOT NULL,
    [LastEditedBy]     	int NOT NULL,
    [ValidFrom]        	datetime2 NOT NULL,
    [ValidTo]          	datetime2 NOT NULL,
    CONSTRAINT [PK_Application_PaymentMethods] PRIMARY KEY CLUSTERED([PaymentMethodID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Application].[PaymentMethods]
    ADD CONSTRAINT [UQ_Application_PaymentMethods_PaymentMethodName]
	UNIQUE ([PaymentMethodName])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
ALTER TABLE [Application].[PaymentMethods]
    ADD CONSTRAINT [FK_Application_PaymentMethods_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE TABLE [Application].[PaymentMethods_Archive]  ( 
    [PaymentMethodID]  	int NOT NULL,
    [PaymentMethodName]	nvarchar(50) NOT NULL,
    [LastEditedBy]     	int NOT NULL,
    [ValidFrom]        	datetime2 NOT NULL,
    [ValidTo]          	datetime2 NOT NULL 
    )
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_PaymentMethods_Archive]
    ON [Application].[PaymentMethods_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
CREATE TABLE [Application].[People]  ( 
    [PersonID]               	int NOT NULL CONSTRAINT [DF_Application_People_PersonID]  DEFAULT (NEXT VALUE FOR [Sequences].[PersonID]),
    [FullName]               	nvarchar(50) NOT NULL,
    [PreferredName]          	nvarchar(50) NOT NULL,
    [SearchName]             	AS (concat([PreferredName],N' ',[FullName])) PERSISTED NOT NULL,
    [IsPermittedToLogon]     	bit NOT NULL,
    [LogonName]              	nvarchar(50) NULL,
    [IsExternalLogonProvider]	bit NOT NULL,
    [HashedPassword]         	varbinary(max) NULL,
    [IsSystemUser]           	bit NOT NULL,
    [IsEmployee]             	bit NOT NULL,
    [IsSalesperson]          	bit NOT NULL,
    [UserPreferences]        	nvarchar(max) NULL,
    [PhoneNumber]            	nvarchar(20) NULL,
    [FaxNumber]              	nvarchar(20) NULL,
    [EmailAddress]           	nvarchar(256) NULL,
    [Photo]                  	varbinary(max) NULL,
    [CustomFields]           	nvarchar(max) NULL,
    [OtherLanguages]         	AS (json_query([CustomFields],N'$.OtherLanguages')),
    [LastEditedBy]           	int NOT NULL,
    [ValidFrom]              	datetime2 NOT NULL,
    [ValidTo]                	datetime2 NOT NULL,
    CONSTRAINT [PK_Application_People] PRIMARY KEY CLUSTERED([PersonID])
 ON [USERDATA])
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Application].[People]
    ADD CONSTRAINT [FK_Application_People_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [IX_Application_People_FullName]
    ON [Application].[People]([FullName])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Application_People_IsEmployee]
    ON [Application].[People]([IsEmployee])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Application_People_IsSalesperson]
    ON [Application].[People]([IsSalesperson])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Application_People_Perf_20160301_05]
    ON [Application].[People]([IsPermittedToLogon], [PersonID])
    INCLUDE ([FullName], [EmailAddress])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE TABLE [Application].[People_Archive]  ( 
    [PersonID]               	int NOT NULL,
    [FullName]               	nvarchar(50) NOT NULL,
    [PreferredName]          	nvarchar(50) NOT NULL,
    [SearchName]             	nvarchar(101) NOT NULL,
    [IsPermittedToLogon]     	bit NOT NULL,
    [LogonName]              	nvarchar(50) NULL,
    [IsExternalLogonProvider]	bit NOT NULL,
    [HashedPassword]         	varbinary(max) NULL,
    [IsSystemUser]           	bit NOT NULL,
    [IsEmployee]             	bit NOT NULL,
    [IsSalesperson]          	bit NOT NULL,
    [UserPreferences]        	nvarchar(max) NULL,
    [PhoneNumber]            	nvarchar(20) NULL,
    [FaxNumber]              	nvarchar(20) NULL,
    [EmailAddress]           	nvarchar(256) NULL,
    [Photo]                  	varbinary(max) NULL,
    [CustomFields]           	nvarchar(max) NULL,
    [OtherLanguages]         	nvarchar(max) NULL,
    [LastEditedBy]           	int NOT NULL,
    [ValidFrom]              	datetime2 NOT NULL,
    [ValidTo]                	datetime2 NOT NULL 
    )
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_People_Archive]
    ON [Application].[People_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
CREATE TABLE [Application].[StateProvinces]  ( 
    [StateProvinceID]         	int NOT NULL CONSTRAINT [DF_Application_StateProvinces_StateProvinceID]  DEFAULT (NEXT VALUE FOR [Sequences].[StateProvinceID]),
    [StateProvinceCode]       	nvarchar(5) NOT NULL,
    [StateProvinceName]       	nvarchar(50) NOT NULL,
    [CountryID]               	int NOT NULL,
    [SalesTerritory]          	nvarchar(50) NOT NULL,
    [Border]                  	[sys].[geography] NULL,
    [LatestRecordedPopulation]	bigint NULL,
    [LastEditedBy]            	int NOT NULL,
    [ValidFrom]               	datetime2 NOT NULL,
    [ValidTo]                 	datetime2 NOT NULL,
    CONSTRAINT [PK_Application_StateProvinces] PRIMARY KEY CLUSTERED([StateProvinceID])
 ON [USERDATA])
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Application].[StateProvinces]
    ADD CONSTRAINT [UQ_Application_StateProvinces_StateProvinceName]
	UNIQUE ([StateProvinceName])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
ALTER TABLE [Application].[StateProvinces]
    ADD CONSTRAINT [FK_Application_StateProvinces_CountryID_Application_Countries]
	FOREIGN KEY([CountryID])
	REFERENCES [Application].[Countries]([CountryID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Application].[StateProvinces]
    ADD CONSTRAINT [FK_Application_StateProvinces_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Application_StateProvinces_CountryID]
    ON [Application].[StateProvinces]([CountryID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Application_StateProvinces_SalesTerritory]
    ON [Application].[StateProvinces]([SalesTerritory])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE TABLE [Application].[StateProvinces_Archive]  ( 
    [StateProvinceID]         	int NOT NULL,
    [StateProvinceCode]       	nvarchar(5) NOT NULL,
    [StateProvinceName]       	nvarchar(50) NOT NULL,
    [CountryID]               	int NOT NULL,
    [SalesTerritory]          	nvarchar(50) NOT NULL,
    [Border]                  	[sys].[geography] NULL,
    [LatestRecordedPopulation]	bigint NULL,
    [LastEditedBy]            	int NOT NULL,
    [ValidFrom]               	datetime2 NOT NULL,
    [ValidTo]                 	datetime2 NOT NULL 
    )
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_StateProvinces_Archive]
    ON [Application].[StateProvinces_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
CREATE TABLE [Application].[SystemParameters]  ( 
    [SystemParameterID]   	int NOT NULL CONSTRAINT [DF_Application_SystemParameters_SystemParameterID]  DEFAULT (NEXT VALUE FOR [Sequences].[SystemParameterID]),
    [DeliveryAddressLine1]	nvarchar(60) NOT NULL,
    [DeliveryAddressLine2]	nvarchar(60) NULL,
    [DeliveryCityID]      	int NOT NULL,
    [DeliveryPostalCode]  	nvarchar(10) NOT NULL,
    [DeliveryLocation]    	[sys].[geography] NOT NULL,
    [PostalAddressLine1]  	nvarchar(60) NOT NULL,
    [PostalAddressLine2]  	nvarchar(60) NULL,
    [PostalCityID]        	int NOT NULL,
    [PostalPostalCode]    	nvarchar(10) NOT NULL,
    [ApplicationSettings] 	nvarchar(max) NOT NULL,
    [LastEditedBy]        	int NOT NULL,
    [LastEditedWhen]      	datetime2 NOT NULL CONSTRAINT [DF_Application_SystemParameters_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Application_SystemParameters] PRIMARY KEY CLUSTERED([SystemParameterID])
 ON [USERDATA])
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Application].[SystemParameters]
    ADD CONSTRAINT [FK_Application_SystemParameters_PostalCityID_Application_Cities]
	FOREIGN KEY([PostalCityID])
	REFERENCES [Application].[Cities]([CityID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Application].[SystemParameters]
    ADD CONSTRAINT [FK_Application_SystemParameters_DeliveryCityID_Application_Cities]
	FOREIGN KEY([DeliveryCityID])
	REFERENCES [Application].[Cities]([CityID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Application].[SystemParameters]
    ADD CONSTRAINT [FK_Application_SystemParameters_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Application_SystemParameters_DeliveryCityID]
    ON [Application].[SystemParameters]([DeliveryCityID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Application_SystemParameters_PostalCityID]
    ON [Application].[SystemParameters]([PostalCityID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE TABLE [Application].[TransactionTypes]  ( 
    [TransactionTypeID]  	int NOT NULL CONSTRAINT [DF_Application_TransactionTypes_TransactionTypeID]  DEFAULT (NEXT VALUE FOR [Sequences].[TransactionTypeID]),
    [TransactionTypeName]	nvarchar(50) NOT NULL,
    [LastEditedBy]       	int NOT NULL,
    [ValidFrom]          	datetime2 NOT NULL,
    [ValidTo]            	datetime2 NOT NULL,
    CONSTRAINT [PK_Application_TransactionTypes] PRIMARY KEY CLUSTERED([TransactionTypeID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Application].[TransactionTypes]
    ADD CONSTRAINT [UQ_Application_TransactionTypes_TransactionTypeName]
	UNIQUE ([TransactionTypeName])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
ALTER TABLE [Application].[TransactionTypes]
    ADD CONSTRAINT [FK_Application_TransactionTypes_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE TABLE [Application].[TransactionTypes_Archive]  ( 
    [TransactionTypeID]  	int NOT NULL,
    [TransactionTypeName]	nvarchar(50) NOT NULL,
    [LastEditedBy]       	int NOT NULL,
    [ValidFrom]          	datetime2 NOT NULL,
    [ValidTo]            	datetime2 NOT NULL 
    )
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_TransactionTypes_Archive]
    ON [Application].[TransactionTypes_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
CREATE TABLE [dbo].[sysdiagrams]  ( 
    [name]        	[sys].[sysname] NOT NULL,
    [principal_id]	int NOT NULL,
    [diagram_id]  	int IDENTITY(1,1) NOT NULL,
    [version]     	int NULL,
    [definition]  	varbinary(max) NULL,
    CONSTRAINT [PK__sysdiagr__C2B05B61A108E995] PRIMARY KEY CLUSTERED([diagram_id])
 ON [USERDATA])
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [dbo].[sysdiagrams]
    ADD CONSTRAINT [UK_principal_name]
	UNIQUE ([principal_id], [name])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
CREATE TABLE [Purchasing].[PurchaseOrderLines]  ( 
    [PurchaseOrderLineID]      	int NOT NULL CONSTRAINT [DF_Purchasing_PurchaseOrderLines_PurchaseOrderLineID]  DEFAULT (NEXT VALUE FOR [Sequences].[PurchaseOrderLineID]),
    [PurchaseOrderID]          	int NOT NULL,
    [StockItemID]              	int NOT NULL,
    [OrderedOuters]            	int NOT NULL,
    [Description]              	nvarchar(100) NOT NULL,
    [ReceivedOuters]           	int NOT NULL,
    [PackageTypeID]            	int NOT NULL,
    [ExpectedUnitPricePerOuter]	decimal(18,2) NULL,
    [LastReceiptDate]          	date NULL,
    [IsOrderLineFinalized]     	bit NOT NULL,
    [LastEditedBy]             	int NOT NULL,
    [LastEditedWhen]           	datetime2 NOT NULL CONSTRAINT [DF_Purchasing_PurchaseOrderLines_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Purchasing_PurchaseOrderLines] PRIMARY KEY CLUSTERED([PurchaseOrderLineID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Purchasing].[PurchaseOrderLines]
    ADD CONSTRAINT [FK_Purchasing_PurchaseOrderLines_StockItemID_Warehouse_StockItems]
	FOREIGN KEY([StockItemID])
	REFERENCES [Warehouse].[StockItems]([StockItemID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[PurchaseOrderLines]
    ADD CONSTRAINT [FK_Purchasing_PurchaseOrderLines_PurchaseOrderID_Purchasing_PurchaseOrders]
	FOREIGN KEY([PurchaseOrderID])
	REFERENCES [Purchasing].[PurchaseOrders]([PurchaseOrderID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[PurchaseOrderLines]
    ADD CONSTRAINT [FK_Purchasing_PurchaseOrderLines_PackageTypeID_Warehouse_PackageTypes]
	FOREIGN KEY([PackageTypeID])
	REFERENCES [Warehouse].[PackageTypes]([PackageTypeID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[PurchaseOrderLines]
    ADD CONSTRAINT [FK_Purchasing_PurchaseOrderLines_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_PurchaseOrderLines_PackageTypeID]
    ON [Purchasing].[PurchaseOrderLines]([PackageTypeID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_PurchaseOrderLines_PurchaseOrderID]
    ON [Purchasing].[PurchaseOrderLines]([PurchaseOrderID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_PurchaseOrderLines_StockItemID]
    ON [Purchasing].[PurchaseOrderLines]([StockItemID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Purchasing_PurchaseOrderLines_Perf_20160301_4]
    ON [Purchasing].[PurchaseOrderLines]([IsOrderLineFinalized], [StockItemID])
    INCLUDE ([OrderedOuters], [ReceivedOuters])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE TABLE [Purchasing].[PurchaseOrders]  ( 
    [PurchaseOrderID]     	int NOT NULL CONSTRAINT [DF_Purchasing_PurchaseOrders_PurchaseOrderID]  DEFAULT (NEXT VALUE FOR [Sequences].[PurchaseOrderID]),
    [SupplierID]          	int NOT NULL,
    [OrderDate]           	date NOT NULL,
    [DeliveryMethodID]    	int NOT NULL,
    [ContactPersonID]     	int NOT NULL,
    [ExpectedDeliveryDate]	date NULL,
    [SupplierReference]   	nvarchar(20) NULL,
    [IsOrderFinalized]    	bit NOT NULL,
    [Comments]            	nvarchar(max) NULL,
    [InternalComments]    	nvarchar(max) NULL,
    [LastEditedBy]        	int NOT NULL,
    [LastEditedWhen]      	datetime2 NOT NULL CONSTRAINT [DF_Purchasing_PurchaseOrders_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Purchasing_PurchaseOrders] PRIMARY KEY CLUSTERED([PurchaseOrderID])
 ON [USERDATA])
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Purchasing].[PurchaseOrders]
    ADD CONSTRAINT [FK_Purchasing_PurchaseOrders_SupplierID_Purchasing_Suppliers]
	FOREIGN KEY([SupplierID])
	REFERENCES [Purchasing].[Suppliers]([SupplierID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[PurchaseOrders]
    ADD CONSTRAINT [FK_Purchasing_PurchaseOrders_DeliveryMethodID_Application_DeliveryMethods]
	FOREIGN KEY([DeliveryMethodID])
	REFERENCES [Application].[DeliveryMethods]([DeliveryMethodID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[PurchaseOrders]
    ADD CONSTRAINT [FK_Purchasing_PurchaseOrders_ContactPersonID_Application_People]
	FOREIGN KEY([ContactPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[PurchaseOrders]
    ADD CONSTRAINT [FK_Purchasing_PurchaseOrders_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_PurchaseOrders_ContactPersonID]
    ON [Purchasing].[PurchaseOrders]([ContactPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_PurchaseOrders_DeliveryMethodID]
    ON [Purchasing].[PurchaseOrders]([DeliveryMethodID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_PurchaseOrders_SupplierID]
    ON [Purchasing].[PurchaseOrders]([SupplierID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE TABLE [Purchasing].[SupplierCategories]  ( 
    [SupplierCategoryID]  	int NOT NULL CONSTRAINT [DF_Purchasing_SupplierCategories_SupplierCategoryID]  DEFAULT (NEXT VALUE FOR [Sequences].[SupplierCategoryID]),
    [SupplierCategoryName]	nvarchar(50) NOT NULL,
    [LastEditedBy]        	int NOT NULL,
    [ValidFrom]           	datetime2 NOT NULL,
    [ValidTo]             	datetime2 NOT NULL,
    CONSTRAINT [PK_Purchasing_SupplierCategories] PRIMARY KEY CLUSTERED([SupplierCategoryID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Purchasing].[SupplierCategories]
    ADD CONSTRAINT [UQ_Purchasing_SupplierCategories_SupplierCategoryName]
	UNIQUE ([SupplierCategoryName])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
ALTER TABLE [Purchasing].[SupplierCategories]
    ADD CONSTRAINT [FK_Purchasing_SupplierCategories_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE TABLE [Purchasing].[SupplierCategories_Archive]  ( 
    [SupplierCategoryID]  	int NOT NULL,
    [SupplierCategoryName]	nvarchar(50) NOT NULL,
    [LastEditedBy]        	int NOT NULL,
    [ValidFrom]           	datetime2 NOT NULL,
    [ValidTo]             	datetime2 NOT NULL 
    )
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_SupplierCategories_Archive]
    ON [Purchasing].[SupplierCategories_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
CREATE TABLE [Purchasing].[Suppliers]  ( 
    [SupplierID]              	int NOT NULL CONSTRAINT [DF_Purchasing_Suppliers_SupplierID]  DEFAULT (NEXT VALUE FOR [Sequences].[SupplierID]),
    [SupplierName]            	nvarchar(100) NOT NULL,
    [SupplierCategoryID]      	int NOT NULL,
    [PrimaryContactPersonID]  	int NOT NULL,
    [AlternateContactPersonID]	int NOT NULL,
    [DeliveryMethodID]        	int NULL,
    [DeliveryCityID]          	int NOT NULL,
    [PostalCityID]            	int NOT NULL,
    [SupplierReference]       	nvarchar(20) NULL,
    [BankAccountName]         	nvarchar(50) NULL,
    [BankAccountBranch]       	nvarchar(50) NULL,
    [BankAccountCode]         	nvarchar(20) NULL,
    [BankAccountNumber]       	nvarchar(20) NULL,
    [BankInternationalCode]   	nvarchar(20) NULL,
    [PaymentDays]             	int NOT NULL,
    [InternalComments]        	nvarchar(max) NULL,
    [PhoneNumber]             	nvarchar(20) NOT NULL,
    [FaxNumber]               	nvarchar(20) NOT NULL,
    [WebsiteURL]              	nvarchar(256) NOT NULL,
    [DeliveryAddressLine1]    	nvarchar(60) NOT NULL,
    [DeliveryAddressLine2]    	nvarchar(60) NULL,
    [DeliveryPostalCode]      	nvarchar(10) NOT NULL,
    [DeliveryLocation]        	[sys].[geography] NULL,
    [PostalAddressLine1]      	nvarchar(60) NOT NULL,
    [PostalAddressLine2]      	nvarchar(60) NULL,
    [PostalPostalCode]        	nvarchar(10) NOT NULL,
    [LastEditedBy]            	int NOT NULL,
    [ValidFrom]               	datetime2 NOT NULL,
    [ValidTo]                 	datetime2 NOT NULL,
    CONSTRAINT [PK_Purchasing_Suppliers] PRIMARY KEY CLUSTERED([SupplierID])
 ON [USERDATA])
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Purchasing].[Suppliers]
    ADD CONSTRAINT [UQ_Purchasing_Suppliers_SupplierName]
	UNIQUE ([SupplierName])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
ALTER TABLE [Purchasing].[Suppliers]
    ADD CONSTRAINT [FK_Purchasing_Suppliers_SupplierCategoryID_Purchasing_SupplierCategories]
	FOREIGN KEY([SupplierCategoryID])
	REFERENCES [Purchasing].[SupplierCategories]([SupplierCategoryID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[Suppliers]
    ADD CONSTRAINT [FK_Purchasing_Suppliers_PrimaryContactPersonID_Application_People]
	FOREIGN KEY([PrimaryContactPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[Suppliers]
    ADD CONSTRAINT [FK_Purchasing_Suppliers_PostalCityID_Application_Cities]
	FOREIGN KEY([PostalCityID])
	REFERENCES [Application].[Cities]([CityID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[Suppliers]
    ADD CONSTRAINT [FK_Purchasing_Suppliers_DeliveryMethodID_Application_DeliveryMethods]
	FOREIGN KEY([DeliveryMethodID])
	REFERENCES [Application].[DeliveryMethods]([DeliveryMethodID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[Suppliers]
    ADD CONSTRAINT [FK_Purchasing_Suppliers_DeliveryCityID_Application_Cities]
	FOREIGN KEY([DeliveryCityID])
	REFERENCES [Application].[Cities]([CityID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[Suppliers]
    ADD CONSTRAINT [FK_Purchasing_Suppliers_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[Suppliers]
    ADD CONSTRAINT [FK_Purchasing_Suppliers_AlternateContactPersonID_Application_People]
	FOREIGN KEY([AlternateContactPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_Suppliers_AlternateContactPersonID]
    ON [Purchasing].[Suppliers]([AlternateContactPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_Suppliers_DeliveryCityID]
    ON [Purchasing].[Suppliers]([DeliveryCityID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_Suppliers_DeliveryMethodID]
    ON [Purchasing].[Suppliers]([DeliveryMethodID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_Suppliers_PostalCityID]
    ON [Purchasing].[Suppliers]([PostalCityID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_Suppliers_PrimaryContactPersonID]
    ON [Purchasing].[Suppliers]([PrimaryContactPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_Suppliers_SupplierCategoryID]
    ON [Purchasing].[Suppliers]([SupplierCategoryID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE TABLE [Purchasing].[Suppliers_Archive]  ( 
    [SupplierID]              	int NOT NULL,
    [SupplierName]            	nvarchar(100) NOT NULL,
    [SupplierCategoryID]      	int NOT NULL,
    [PrimaryContactPersonID]  	int NOT NULL,
    [AlternateContactPersonID]	int NOT NULL,
    [DeliveryMethodID]        	int NULL,
    [DeliveryCityID]          	int NOT NULL,
    [PostalCityID]            	int NOT NULL,
    [SupplierReference]       	nvarchar(20) NULL,
    [BankAccountName]         	nvarchar(50) NULL,
    [BankAccountBranch]       	nvarchar(50) NULL,
    [BankAccountCode]         	nvarchar(20) NULL,
    [BankAccountNumber]       	nvarchar(20) NULL,
    [BankInternationalCode]   	nvarchar(20) NULL,
    [PaymentDays]             	int NOT NULL,
    [InternalComments]        	nvarchar(max) NULL,
    [PhoneNumber]             	nvarchar(20) NOT NULL,
    [FaxNumber]               	nvarchar(20) NOT NULL,
    [WebsiteURL]              	nvarchar(256) NOT NULL,
    [DeliveryAddressLine1]    	nvarchar(60) NOT NULL,
    [DeliveryAddressLine2]    	nvarchar(60) NULL,
    [DeliveryPostalCode]      	nvarchar(10) NOT NULL,
    [DeliveryLocation]        	[sys].[geography] NULL,
    [PostalAddressLine1]      	nvarchar(60) NOT NULL,
    [PostalAddressLine2]      	nvarchar(60) NULL,
    [PostalPostalCode]        	nvarchar(10) NOT NULL,
    [LastEditedBy]            	int NOT NULL,
    [ValidFrom]               	datetime2 NOT NULL,
    [ValidTo]                 	datetime2 NOT NULL 
    )
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_Suppliers_Archive]
    ON [Purchasing].[Suppliers_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE TABLE [Purchasing].[SupplierTransactions]  ( 
    [SupplierTransactionID]	int NOT NULL CONSTRAINT [DF_Purchasing_SupplierTransactions_SupplierTransactionID]  DEFAULT (NEXT VALUE FOR [Sequences].[TransactionID]),
    [SupplierID]           	int NOT NULL,
    [TransactionTypeID]    	int NOT NULL,
    [PurchaseOrderID]      	int NULL,
    [PaymentMethodID]      	int NULL,
    [SupplierInvoiceNumber]	nvarchar(20) NULL,
    [TransactionDate]      	date NOT NULL,
    [AmountExcludingTax]   	decimal(18,2) NOT NULL,
    [TaxAmount]            	decimal(18,2) NOT NULL,
    [TransactionAmount]    	decimal(18,2) NOT NULL,
    [OutstandingBalance]   	decimal(18,2) NOT NULL,
    [FinalizationDate]     	date NULL,
    [IsFinalized]          	AS (case when [FinalizationDate] IS NULL then CONVERT([bit],(0)) else CONVERT([bit],(1)) end) PERSISTED,
    [LastEditedBy]         	int NOT NULL,
    [LastEditedWhen]       	datetime2 NOT NULL CONSTRAINT [DF_Purchasing_SupplierTransactions_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Purchasing_SupplierTransactions] PRIMARY KEY NONCLUSTERED([SupplierTransactionID])
	WITH (
		DATA_COMPRESSION = NONE
    ) ON [USERDATA])
	 ON [PS_TransactionDate] ([TransactionDate]) 
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Purchasing].[SupplierTransactions]
    ADD CONSTRAINT [FK_Purchasing_SupplierTransactions_TransactionTypeID_Application_TransactionTypes]
	FOREIGN KEY([TransactionTypeID])
	REFERENCES [Application].[TransactionTypes]([TransactionTypeID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[SupplierTransactions]
    ADD CONSTRAINT [FK_Purchasing_SupplierTransactions_SupplierID_Purchasing_Suppliers]
	FOREIGN KEY([SupplierID])
	REFERENCES [Purchasing].[Suppliers]([SupplierID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[SupplierTransactions]
    ADD CONSTRAINT [FK_Purchasing_SupplierTransactions_PurchaseOrderID_Purchasing_PurchaseOrders]
	FOREIGN KEY([PurchaseOrderID])
	REFERENCES [Purchasing].[PurchaseOrders]([PurchaseOrderID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[SupplierTransactions]
    ADD CONSTRAINT [FK_Purchasing_SupplierTransactions_PaymentMethodID_Application_PaymentMethods]
	FOREIGN KEY([PaymentMethodID])
	REFERENCES [Application].[PaymentMethods]([PaymentMethodID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Purchasing].[SupplierTransactions]
    ADD CONSTRAINT [FK_Purchasing_SupplierTransactions_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE CLUSTERED INDEX [CX_Purchasing_SupplierTransactions]
    ON [Purchasing].[SupplierTransactions]([TransactionDate])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_SupplierTransactions_PaymentMethodID]
    ON [Purchasing].[SupplierTransactions]([PaymentMethodID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_SupplierTransactions_PurchaseOrderID]
    ON [Purchasing].[SupplierTransactions]([PurchaseOrderID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_SupplierTransactions_SupplierID]
    ON [Purchasing].[SupplierTransactions]([SupplierID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [FK_Purchasing_SupplierTransactions_TransactionTypeID]
    ON [Purchasing].[SupplierTransactions]([TransactionTypeID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [IX_Purchasing_SupplierTransactions_IsFinalized]
    ON [Purchasing].[SupplierTransactions]([IsFinalized])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
CREATE TABLE [Sales].[BuyingGroups]  ( 
    [BuyingGroupID]  	int NOT NULL CONSTRAINT [DF_Sales_BuyingGroups_BuyingGroupID]  DEFAULT (NEXT VALUE FOR [Sequences].[BuyingGroupID]),
    [BuyingGroupName]	nvarchar(50) NOT NULL,
    [LastEditedBy]   	int NOT NULL,
    [ValidFrom]      	datetime2 NOT NULL,
    [ValidTo]        	datetime2 NOT NULL,
    CONSTRAINT [PK_Sales_BuyingGroups] PRIMARY KEY CLUSTERED([BuyingGroupID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Sales].[BuyingGroups]
    ADD CONSTRAINT [UQ_Sales_BuyingGroups_BuyingGroupName]
	UNIQUE ([BuyingGroupName])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
ALTER TABLE [Sales].[BuyingGroups]
    ADD CONSTRAINT [FK_Sales_BuyingGroups_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE TABLE [Sales].[BuyingGroups_Archive]  ( 
    [BuyingGroupID]  	int NOT NULL,
    [BuyingGroupName]	nvarchar(50) NOT NULL,
    [LastEditedBy]   	int NOT NULL,
    [ValidFrom]      	datetime2 NOT NULL,
    [ValidTo]        	datetime2 NOT NULL 
    )
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_BuyingGroups_Archive]
    ON [Sales].[BuyingGroups_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
CREATE TABLE [Sales].[CustomerCategories]  ( 
    [CustomerCategoryID]  	int NOT NULL CONSTRAINT [DF_Sales_CustomerCategories_CustomerCategoryID]  DEFAULT (NEXT VALUE FOR [Sequences].[CustomerCategoryID]),
    [CustomerCategoryName]	nvarchar(50) NOT NULL,
    [LastEditedBy]        	int NOT NULL,
    [ValidFrom]           	datetime2 NOT NULL,
    [ValidTo]             	datetime2 NOT NULL,
    CONSTRAINT [PK_Sales_CustomerCategories] PRIMARY KEY CLUSTERED([CustomerCategoryID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Sales].[CustomerCategories]
    ADD CONSTRAINT [UQ_Sales_CustomerCategories_CustomerCategoryName]
	UNIQUE ([CustomerCategoryName])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
ALTER TABLE [Sales].[CustomerCategories]
    ADD CONSTRAINT [FK_Sales_CustomerCategories_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE TABLE [Sales].[CustomerCategories_Archive]  ( 
    [CustomerCategoryID]  	int NOT NULL,
    [CustomerCategoryName]	nvarchar(50) NOT NULL,
    [LastEditedBy]        	int NOT NULL,
    [ValidFrom]           	datetime2 NOT NULL,
    [ValidTo]             	datetime2 NOT NULL 
    )
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_CustomerCategories_Archive]
    ON [Sales].[CustomerCategories_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
CREATE TABLE [Sales].[Customers]  ( 
    [CustomerID]                	int NOT NULL CONSTRAINT [DF_Sales_Customers_CustomerID]  DEFAULT (NEXT VALUE FOR [Sequences].[CustomerID]),
    [CustomerName]              	nvarchar(100) NOT NULL,
    [BillToCustomerID]          	int NOT NULL,
    [CustomerCategoryID]        	int NOT NULL,
    [BuyingGroupID]             	int NULL,
    [PrimaryContactPersonID]    	int NOT NULL,
    [AlternateContactPersonID]  	int NULL,
    [DeliveryMethodID]          	int NOT NULL,
    [DeliveryCityID]            	int NOT NULL,
    [PostalCityID]              	int NOT NULL,
    [CreditLimit]               	decimal(18,2) NULL,
    [AccountOpenedDate]         	date NOT NULL,
    [StandardDiscountPercentage]	decimal(18,3) NOT NULL,
    [IsStatementSent]           	bit NOT NULL,
    [IsOnCreditHold]            	bit NOT NULL,
    [PaymentDays]               	int NOT NULL,
    [PhoneNumber]               	nvarchar(20) NOT NULL,
    [FaxNumber]                 	nvarchar(20) NOT NULL,
    [DeliveryRun]               	nvarchar(5) NULL,
    [RunPosition]               	nvarchar(5) NULL,
    [WebsiteURL]                	nvarchar(256) NOT NULL,
    [DeliveryAddressLine1]      	nvarchar(60) NOT NULL,
    [DeliveryAddressLine2]      	nvarchar(60) NULL,
    [DeliveryPostalCode]        	nvarchar(10) NOT NULL,
    [DeliveryLocation]          	[sys].[geography] NULL,
    [PostalAddressLine1]        	nvarchar(60) NOT NULL,
    [PostalAddressLine2]        	nvarchar(60) NULL,
    [PostalPostalCode]          	nvarchar(10) NOT NULL,
    [LastEditedBy]              	int NOT NULL,
    [ValidFrom]                 	datetime2 NOT NULL,
    [ValidTo]                   	datetime2 NOT NULL,
    CONSTRAINT [PK_Sales_Customers] PRIMARY KEY CLUSTERED([CustomerID])
 ON [USERDATA])
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [UQ_Sales_Customers_CustomerName]
	UNIQUE ([CustomerName])
	WITH (
		DATA_COMPRESSION = NONE
	) ON [USERDATA]
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [FK_Sales_Customers_PrimaryContactPersonID_Application_People]
	FOREIGN KEY([PrimaryContactPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [FK_Sales_Customers_PostalCityID_Application_Cities]
	FOREIGN KEY([PostalCityID])
	REFERENCES [Application].[Cities]([CityID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [FK_Sales_Customers_DeliveryMethodID_Application_DeliveryMethods]
	FOREIGN KEY([DeliveryMethodID])
	REFERENCES [Application].[DeliveryMethods]([DeliveryMethodID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [FK_Sales_Customers_DeliveryCityID_Application_Cities]
	FOREIGN KEY([DeliveryCityID])
	REFERENCES [Application].[Cities]([CityID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [FK_Sales_Customers_CustomerCategoryID_Sales_CustomerCategories]
	FOREIGN KEY([CustomerCategoryID])
	REFERENCES [Sales].[CustomerCategories]([CustomerCategoryID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [FK_Sales_Customers_BuyingGroupID_Sales_BuyingGroups]
	FOREIGN KEY([BuyingGroupID])
	REFERENCES [Sales].[BuyingGroups]([BuyingGroupID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [FK_Sales_Customers_BillToCustomerID_Sales_Customers]
	FOREIGN KEY([BillToCustomerID])
	REFERENCES [Sales].[Customers]([CustomerID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [FK_Sales_Customers_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Customers]
    ADD CONSTRAINT [FK_Sales_Customers_AlternateContactPersonID_Application_People]
	FOREIGN KEY([AlternateContactPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Customers_AlternateContactPersonID]
    ON [Sales].[Customers]([AlternateContactPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Customers_BuyingGroupID]
    ON [Sales].[Customers]([BuyingGroupID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Customers_CustomerCategoryID]
    ON [Sales].[Customers]([CustomerCategoryID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Customers_DeliveryCityID]
    ON [Sales].[Customers]([DeliveryCityID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Customers_DeliveryMethodID]
    ON [Sales].[Customers]([DeliveryMethodID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Customers_PostalCityID]
    ON [Sales].[Customers]([PostalCityID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Customers_PrimaryContactPersonID]
    ON [Sales].[Customers]([PrimaryContactPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Sales_Customers_Perf_20160301_06]
    ON [Sales].[Customers]([IsOnCreditHold], [CustomerID], [BillToCustomerID])
    INCLUDE ([PrimaryContactPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE TABLE [Sales].[Customers_Archive]  ( 
    [CustomerID]                	int NOT NULL,
    [CustomerName]              	nvarchar(100) NOT NULL,
    [BillToCustomerID]          	int NOT NULL,
    [CustomerCategoryID]        	int NOT NULL,
    [BuyingGroupID]             	int NULL,
    [PrimaryContactPersonID]    	int NOT NULL,
    [AlternateContactPersonID]  	int NULL,
    [DeliveryMethodID]          	int NOT NULL,
    [DeliveryCityID]            	int NOT NULL,
    [PostalCityID]              	int NOT NULL,
    [CreditLimit]               	decimal(18,2) NULL,
    [AccountOpenedDate]         	date NOT NULL,
    [StandardDiscountPercentage]	decimal(18,3) NOT NULL,
    [IsStatementSent]           	bit NOT NULL,
    [IsOnCreditHold]            	bit NOT NULL,
    [PaymentDays]               	int NOT NULL,
    [PhoneNumber]               	nvarchar(20) NOT NULL,
    [FaxNumber]                 	nvarchar(20) NOT NULL,
    [DeliveryRun]               	nvarchar(5) NULL,
    [RunPosition]               	nvarchar(5) NULL,
    [WebsiteURL]                	nvarchar(256) NOT NULL,
    [DeliveryAddressLine1]      	nvarchar(60) NOT NULL,
    [DeliveryAddressLine2]      	nvarchar(60) NULL,
    [DeliveryPostalCode]        	nvarchar(10) NOT NULL,
    [DeliveryLocation]          	[sys].[geography] NULL,
    [PostalAddressLine1]        	nvarchar(60) NOT NULL,
    [PostalAddressLine2]        	nvarchar(60) NULL,
    [PostalPostalCode]          	nvarchar(10) NOT NULL,
    [LastEditedBy]              	int NOT NULL,
    [ValidFrom]                 	datetime2 NOT NULL,
    [ValidTo]                   	datetime2 NOT NULL 
    )
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = PAGE
	)
GO
CREATE CLUSTERED INDEX [ix_Customers_Archive]
    ON [Sales].[Customers_Archive]([ValidTo], [ValidFrom])
    WITH (	
		DATA_COMPRESSION = PAGE
    )
    ON [USERDATA]
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE TABLE [Sales].[CustomerTransactions]  ( 
    [CustomerTransactionID]	int NOT NULL CONSTRAINT [DF_Sales_CustomerTransactions_CustomerTransactionID]  DEFAULT (NEXT VALUE FOR [Sequences].[TransactionID]),
    [CustomerID]           	int NOT NULL,
    [TransactionTypeID]    	int NOT NULL,
    [InvoiceID]            	int NULL,
    [PaymentMethodID]      	int NULL,
    [TransactionDate]      	date NOT NULL,
    [AmountExcludingTax]   	decimal(18,2) NOT NULL,
    [TaxAmount]            	decimal(18,2) NOT NULL,
    [TransactionAmount]    	decimal(18,2) NOT NULL,
    [OutstandingBalance]   	decimal(18,2) NOT NULL,
    [FinalizationDate]     	date NULL,
    [IsFinalized]          	AS (case when [FinalizationDate] IS NULL then CONVERT([bit],(0)) else CONVERT([bit],(1)) end) PERSISTED,
    [LastEditedBy]         	int NOT NULL,
    [LastEditedWhen]       	datetime2 NOT NULL CONSTRAINT [DF_Sales_CustomerTransactions_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Sales_CustomerTransactions] PRIMARY KEY NONCLUSTERED([CustomerTransactionID])
	WITH (
		DATA_COMPRESSION = NONE
    ) ON [USERDATA])
	 ON [PS_TransactionDate] ([TransactionDate]) 
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Sales].[CustomerTransactions]
    ADD CONSTRAINT [FK_Sales_CustomerTransactions_TransactionTypeID_Application_TransactionTypes]
	FOREIGN KEY([TransactionTypeID])
	REFERENCES [Application].[TransactionTypes]([TransactionTypeID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[CustomerTransactions]
    ADD CONSTRAINT [FK_Sales_CustomerTransactions_PaymentMethodID_Application_PaymentMethods]
	FOREIGN KEY([PaymentMethodID])
	REFERENCES [Application].[PaymentMethods]([PaymentMethodID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[CustomerTransactions]
    ADD CONSTRAINT [FK_Sales_CustomerTransactions_InvoiceID_Sales_Invoices]
	FOREIGN KEY([InvoiceID])
	REFERENCES [Sales].[Invoices]([InvoiceID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[CustomerTransactions]
    ADD CONSTRAINT [FK_Sales_CustomerTransactions_CustomerID_Sales_Customers]
	FOREIGN KEY([CustomerID])
	REFERENCES [Sales].[Customers]([CustomerID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[CustomerTransactions]
    ADD CONSTRAINT [FK_Sales_CustomerTransactions_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE CLUSTERED INDEX [CX_Sales_CustomerTransactions]
    ON [Sales].[CustomerTransactions]([TransactionDate])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [FK_Sales_CustomerTransactions_CustomerID]
    ON [Sales].[CustomerTransactions]([CustomerID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [FK_Sales_CustomerTransactions_InvoiceID]
    ON [Sales].[CustomerTransactions]([InvoiceID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [FK_Sales_CustomerTransactions_PaymentMethodID]
    ON [Sales].[CustomerTransactions]([PaymentMethodID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [FK_Sales_CustomerTransactions_TransactionTypeID]
    ON [Sales].[CustomerTransactions]([TransactionTypeID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
IF NOT EXISTS (select 'exists' from sys.partition_functions where name = 'PF_TransactionDate')
	CREATE PARTITION FUNCTION [PF_TransactionDate] (date) AS RANGE RIGHT FOR VALUES (N'Jan  1 2014',N'Jan  1 2015',N'Jan  1 2016',N'Jan  1 2017')
GO
IF NOT EXISTS (select 'exists' from sys.partition_schemes where name = 'PS_TransactionDate')
	CREATE PARTITION SCHEME [PS_TransactionDate] AS PARTITION [PF_TransactionDate] TO ([USERDATA],[USERDATA],[USERDATA],[USERDATA],[USERDATA])
GO
CREATE NONCLUSTERED INDEX [IX_Sales_CustomerTransactions_IsFinalized]
    ON [Sales].[CustomerTransactions]([IsFinalized])
    WITH (	
		DATA_COMPRESSION = NONE
    )
	ON [PS_TransactionDate] (TransactionDate) 
GO
CREATE TABLE [Sales].[InvoiceLines]  ( 
    [InvoiceLineID] 	int NOT NULL CONSTRAINT [DF_Sales_InvoiceLines_InvoiceLineID]  DEFAULT (NEXT VALUE FOR [Sequences].[InvoiceLineID]),
    [InvoiceID]     	int NOT NULL,
    [StockItemID]   	int NOT NULL,
    [Description]   	nvarchar(100) NOT NULL,
    [PackageTypeID] 	int NOT NULL,
    [Quantity]      	int NOT NULL,
    [UnitPrice]     	decimal(18,2) NULL,
    [TaxRate]       	decimal(18,3) NOT NULL,
    [TaxAmount]     	decimal(18,2) NOT NULL,
    [LineProfit]    	decimal(18,2) NOT NULL,
    [ExtendedPrice] 	decimal(18,2) NOT NULL,
    [LastEditedBy]  	int NOT NULL,
    [LastEditedWhen]	datetime2 NOT NULL CONSTRAINT [DF_Sales_InvoiceLines_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Sales_InvoiceLines] PRIMARY KEY CLUSTERED([InvoiceLineID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Sales].[InvoiceLines]
    ADD CONSTRAINT [FK_Sales_InvoiceLines_StockItemID_Warehouse_StockItems]
	FOREIGN KEY([StockItemID])
	REFERENCES [Warehouse].[StockItems]([StockItemID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[InvoiceLines]
    ADD CONSTRAINT [FK_Sales_InvoiceLines_PackageTypeID_Warehouse_PackageTypes]
	FOREIGN KEY([PackageTypeID])
	REFERENCES [Warehouse].[PackageTypes]([PackageTypeID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[InvoiceLines]
    ADD CONSTRAINT [FK_Sales_InvoiceLines_InvoiceID_Sales_Invoices]
	FOREIGN KEY([InvoiceID])
	REFERENCES [Sales].[Invoices]([InvoiceID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[InvoiceLines]
    ADD CONSTRAINT [FK_Sales_InvoiceLines_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Sales_InvoiceLines_InvoiceID]
    ON [Sales].[InvoiceLines]([InvoiceID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_InvoiceLines_PackageTypeID]
    ON [Sales].[InvoiceLines]([PackageTypeID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_InvoiceLines_StockItemID]
    ON [Sales].[InvoiceLines]([StockItemID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED COLUMNSTORE INDEX [NCCX_Sales_InvoiceLines]
    ON [Sales].[InvoiceLines]([InvoiceID], [StockItemID], [Quantity], [UnitPrice], [LineProfit], [LastEditedWhen])
    WITH (
		DATA_COMPRESSION = COLUMNSTORE
    )
    ON [USERDATA]
GO
CREATE TABLE [Sales].[Invoices]  ( 
    [InvoiceID]                  	int NOT NULL CONSTRAINT [DF_Sales_Invoices_InvoiceID]  DEFAULT (NEXT VALUE FOR [Sequences].[InvoiceID]),
    [CustomerID]                 	int NOT NULL,
    [BillToCustomerID]           	int NOT NULL,
    [OrderID]                    	int NULL,
    [DeliveryMethodID]           	int NOT NULL,
    [ContactPersonID]            	int NOT NULL,
    [AccountsPersonID]           	int NOT NULL,
    [SalespersonPersonID]        	int NOT NULL,
    [PackedByPersonID]           	int NOT NULL,
    [InvoiceDate]                	date NOT NULL,
    [CustomerPurchaseOrderNumber]	nvarchar(20) NULL,
    [IsCreditNote]               	bit NOT NULL,
    [CreditNoteReason]           	nvarchar(max) NULL,
    [Comments]                   	nvarchar(max) NULL,
    [DeliveryInstructions]       	nvarchar(max) NULL,
    [InternalComments]           	nvarchar(max) NULL,
    [TotalDryItems]              	int NOT NULL,
    [TotalChillerItems]          	int NOT NULL,
    [DeliveryRun]                	nvarchar(5) NULL,
    [RunPosition]                	nvarchar(5) NULL,
    [ReturnedDeliveryData]       	nvarchar(max) NULL,
    [ConfirmedDeliveryTime]      	AS (TRY_CONVERT([datetime2](7),json_value([ReturnedDeliveryData],N'$.DeliveredWhen'),(126))),
    [ConfirmedReceivedBy]        	AS (json_value([ReturnedDeliveryData],N'$.ReceivedBy')),
    [LastEditedBy]               	int NOT NULL,
    [LastEditedWhen]             	datetime2 NOT NULL CONSTRAINT [DF_Sales_Invoices_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Sales_Invoices] PRIMARY KEY CLUSTERED([InvoiceID])
 ON [USERDATA])
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [CK_Sales_Invoices_ReturnedDeliveryData_Must_Be_Valid_JSON] CHECK ([ReturnedDeliveryData] IS NULL OR isjson([ReturnedDeliveryData])<>(0))
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [FK_Sales_Invoices_SalespersonPersonID_Application_People]
	FOREIGN KEY([SalespersonPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [FK_Sales_Invoices_PackedByPersonID_Application_People]
	FOREIGN KEY([PackedByPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [FK_Sales_Invoices_OrderID_Sales_Orders]
	FOREIGN KEY([OrderID])
	REFERENCES [Sales].[Orders]([OrderID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [FK_Sales_Invoices_DeliveryMethodID_Application_DeliveryMethods]
	FOREIGN KEY([DeliveryMethodID])
	REFERENCES [Application].[DeliveryMethods]([DeliveryMethodID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [FK_Sales_Invoices_CustomerID_Sales_Customers]
	FOREIGN KEY([CustomerID])
	REFERENCES [Sales].[Customers]([CustomerID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [FK_Sales_Invoices_ContactPersonID_Application_People]
	FOREIGN KEY([ContactPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [FK_Sales_Invoices_BillToCustomerID_Sales_Customers]
	FOREIGN KEY([BillToCustomerID])
	REFERENCES [Sales].[Customers]([CustomerID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [FK_Sales_Invoices_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Invoices]
    ADD CONSTRAINT [FK_Sales_Invoices_AccountsPersonID_Application_People]
	FOREIGN KEY([AccountsPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_AccountsPersonID]
    ON [Sales].[Invoices]([AccountsPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_BillToCustomerID]
    ON [Sales].[Invoices]([BillToCustomerID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_ContactPersonID]
    ON [Sales].[Invoices]([ContactPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_CustomerID]
    ON [Sales].[Invoices]([CustomerID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_DeliveryMethodID]
    ON [Sales].[Invoices]([DeliveryMethodID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_OrderID]
    ON [Sales].[Invoices]([OrderID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_PackedByPersonID]
    ON [Sales].[Invoices]([PackedByPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_SalespersonPersonID]
    ON [Sales].[Invoices]([SalespersonPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Sales_Invoices_ConfirmedDeliveryTime]
    ON [Sales].[Invoices]([ConfirmedDeliveryTime])
    INCLUDE ([ConfirmedReceivedBy])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE TABLE [Sales].[OrderLines]  ( 
    [OrderLineID]         	int NOT NULL CONSTRAINT [DF_Sales_OrderLines_OrderLineID]  DEFAULT (NEXT VALUE FOR [Sequences].[OrderLineID]),
    [OrderID]             	int NOT NULL,
    [StockItemID]         	int NOT NULL,
    [Description]         	nvarchar(100) NOT NULL,
    [PackageTypeID]       	int NOT NULL,
    [Quantity]            	int NOT NULL,
    [UnitPrice]           	decimal(18,2) NULL,
    [TaxRate]             	decimal(18,3) NOT NULL,
    [PickedQuantity]      	int NOT NULL,
    [PickingCompletedWhen]	datetime2 NULL,
    [LastEditedBy]        	int NOT NULL,
    [LastEditedWhen]      	datetime2 NOT NULL CONSTRAINT [DF_Sales_OrderLines_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Sales_OrderLines] PRIMARY KEY CLUSTERED([OrderLineID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Sales].[OrderLines]
    ADD CONSTRAINT [FK_Sales_OrderLines_StockItemID_Warehouse_StockItems]
	FOREIGN KEY([StockItemID])
	REFERENCES [Warehouse].[StockItems]([StockItemID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[OrderLines]
    ADD CONSTRAINT [FK_Sales_OrderLines_PackageTypeID_Warehouse_PackageTypes]
	FOREIGN KEY([PackageTypeID])
	REFERENCES [Warehouse].[PackageTypes]([PackageTypeID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[OrderLines]
    ADD CONSTRAINT [FK_Sales_OrderLines_OrderID_Sales_Orders]
	FOREIGN KEY([OrderID])
	REFERENCES [Sales].[Orders]([OrderID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[OrderLines]
    ADD CONSTRAINT [FK_Sales_OrderLines_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Sales_OrderLines_OrderID]
    ON [Sales].[OrderLines]([OrderID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_OrderLines_PackageTypeID]
    ON [Sales].[OrderLines]([PackageTypeID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Sales_OrderLines_AllocatedStockItems]
    ON [Sales].[OrderLines]([StockItemID])
    INCLUDE ([PickedQuantity])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Sales_OrderLines_Perf_20160301_01]
    ON [Sales].[OrderLines]([PickingCompletedWhen], [OrderID], [OrderLineID])
    INCLUDE ([Quantity], [StockItemID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [IX_Sales_OrderLines_Perf_20160301_02]
    ON [Sales].[OrderLines]([StockItemID], [PickingCompletedWhen])
    INCLUDE ([OrderID], [PickedQuantity])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED COLUMNSTORE INDEX [NCCX_Sales_OrderLines]
    ON [Sales].[OrderLines]([OrderID], [StockItemID], [Description], [Quantity], [UnitPrice], [PickedQuantity])
    WITH (
		DATA_COMPRESSION = COLUMNSTORE
    )
    ON [USERDATA]
GO
CREATE TABLE [Sales].[Orders]  ( 
    [OrderID]                    	int NOT NULL CONSTRAINT [DF_Sales_Orders_OrderID]  DEFAULT (NEXT VALUE FOR [Sequences].[OrderID]),
    [CustomerID]                 	int NOT NULL,
    [SalespersonPersonID]        	int NOT NULL,
    [PickedByPersonID]           	int NULL,
    [ContactPersonID]            	int NOT NULL,
    [BackorderOrderID]           	int NULL,
    [OrderDate]                  	date NOT NULL,
    [ExpectedDeliveryDate]       	date NOT NULL,
    [CustomerPurchaseOrderNumber]	nvarchar(20) NULL,
    [IsUndersupplyBackordered]   	bit NOT NULL,
    [Comments]                   	nvarchar(max) NULL,
    [DeliveryInstructions]       	nvarchar(max) NULL,
    [InternalComments]           	nvarchar(max) NULL,
    [PickingCompletedWhen]       	datetime2 NULL,
    [LastEditedBy]               	int NOT NULL,
    [LastEditedWhen]             	datetime2 NOT NULL CONSTRAINT [DF_Sales_Orders_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Sales_Orders] PRIMARY KEY CLUSTERED([OrderID])
 ON [USERDATA])
ON [USERDATA]
	TEXTIMAGE_ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Sales].[Orders]
    ADD CONSTRAINT [FK_Sales_Orders_SalespersonPersonID_Application_People]
	FOREIGN KEY([SalespersonPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Orders]
    ADD CONSTRAINT [FK_Sales_Orders_PickedByPersonID_Application_People]
	FOREIGN KEY([PickedByPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Orders]
    ADD CONSTRAINT [FK_Sales_Orders_CustomerID_Sales_Customers]
	FOREIGN KEY([CustomerID])
	REFERENCES [Sales].[Customers]([CustomerID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Orders]
    ADD CONSTRAINT [FK_Sales_Orders_ContactPersonID_Application_People]
	FOREIGN KEY([ContactPersonID])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Orders]
    ADD CONSTRAINT [FK_Sales_Orders_BackorderOrderID_Sales_Orders]
	FOREIGN KEY([BackorderOrderID])
	REFERENCES [Sales].[Orders]([OrderID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[Orders]
    ADD CONSTRAINT [FK_Sales_Orders_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Orders_ContactPersonID]
    ON [Sales].[Orders]([ContactPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Orders_CustomerID]
    ON [Sales].[Orders]([CustomerID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Orders_PickedByPersonID]
    ON [Sales].[Orders]([PickedByPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_Orders_SalespersonPersonID]
    ON [Sales].[Orders]([SalespersonPersonID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE TABLE [Sales].[SpecialDeals]  ( 
    [SpecialDealID]     	int NOT NULL CONSTRAINT [DF_Sales_SpecialDeals_SpecialDealID]  DEFAULT (NEXT VALUE FOR [Sequences].[SpecialDealID]),
    [StockItemID]       	int NULL,
    [CustomerID]        	int NULL,
    [BuyingGroupID]     	int NULL,
    [CustomerCategoryID]	int NULL,
    [StockGroupID]      	int NULL,
    [DealDescription]   	nvarchar(30) NOT NULL,
    [StartDate]         	date NOT NULL,
    [EndDate]           	date NOT NULL,
    [DiscountAmount]    	decimal(18,2) NULL,
    [DiscountPercentage]	decimal(18,3) NULL,
    [UnitPrice]         	decimal(18,2) NULL,
    [LastEditedBy]      	int NOT NULL,
    [LastEditedWhen]    	datetime2 NOT NULL CONSTRAINT [DF_Sales_SpecialDeals_LastEditedWhen]  DEFAULT (sysdatetime()),
    CONSTRAINT [PK_Sales_SpecialDeals] PRIMARY KEY CLUSTERED([SpecialDealID])
 ON [USERDATA])
ON [USERDATA]
	WITH (
		DATA_COMPRESSION = NONE
	)
GO
ALTER TABLE [Sales].[SpecialDeals]
    ADD CONSTRAINT [CK_Sales_SpecialDeals_Unit_Price_Deal_Requires_Special_StockItem] CHECK ([StockItemID] IS NOT NULL AND [UnitPrice] IS NOT NULL OR [UnitPrice] IS NULL)
GO
ALTER TABLE [Sales].[SpecialDeals]
    ADD CONSTRAINT [CK_Sales_SpecialDeals_Exactly_One_NOT_NULL_Pricing_Option_Is_Required] CHECK (((case when [DiscountAmount] IS NULL then (0) else (1) end+case when [DiscountPercentage] IS NULL then (0) else (1) end)+case when [UnitPrice] IS NULL then (0) else (1) end)=(1))
GO
ALTER TABLE [Sales].[SpecialDeals]
    ADD CONSTRAINT [FK_Sales_SpecialDeals_StockItemID_Warehouse_StockItems]
	FOREIGN KEY([StockItemID])
	REFERENCES [Warehouse].[StockItems]([StockItemID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[SpecialDeals]
    ADD CONSTRAINT [FK_Sales_SpecialDeals_StockGroupID_Warehouse_StockGroups]
	FOREIGN KEY([StockGroupID])
	REFERENCES [Warehouse].[StockGroups]([StockGroupID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[SpecialDeals]
    ADD CONSTRAINT [FK_Sales_SpecialDeals_CustomerID_Sales_Customers]
	FOREIGN KEY([CustomerID])
	REFERENCES [Sales].[Customers]([CustomerID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[SpecialDeals]
    ADD CONSTRAINT [FK_Sales_SpecialDeals_CustomerCategoryID_Sales_CustomerCategories]
	FOREIGN KEY([CustomerCategoryID])
	REFERENCES [Sales].[CustomerCategories]([CustomerCategoryID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[SpecialDeals]
    ADD CONSTRAINT [FK_Sales_SpecialDeals_BuyingGroupID_Sales_BuyingGroups]
	FOREIGN KEY([BuyingGroupID])
	REFERENCES [Sales].[BuyingGroups]([BuyingGroupID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
ALTER TABLE [Sales].[SpecialDeals]
    ADD CONSTRAINT [FK_Sales_SpecialDeals_Application_People]
	FOREIGN KEY([LastEditedBy])
	REFERENCES [Application].[People]([PersonID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
CREATE NONCLUSTERED INDEX [FK_Sales_SpecialDeals_BuyingGroupID]
    ON [Sales].[SpecialDeals]([BuyingGroupID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_SpecialDeals_CustomerCategoryID]
    ON [Sales].[SpecialDeals]([CustomerCategoryID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_SpecialDeals_CustomerID]
    ON [Sales].[SpecialDeals]([CustomerID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_SpecialDeals_StockGroupID]
    ON [Sales].[SpecialDeals]([StockGroupID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Sales_SpecialDeals_StockItemID]
    ON [Sales].[SpecialDeals]([StockItemID])
    WITH (	
		DATA_COMPRESSION = NONE
    )
    ON [USERDATA]
GO
