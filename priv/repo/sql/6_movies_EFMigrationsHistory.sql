create table __EFMigrationsHistory
(
    MigrationId    varchar(150) not null
        primary key,
    ProductVersion varchar(32)  not null
);

INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion) VALUES ('20211206223736_Initial', '6.0.0');
