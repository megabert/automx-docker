CREATE TABLE automx ( 
        id                      integer                         primary key, 
        domain                  varchar(200)                    not null,
        smtp_enabled            varchar(5)                      not null DEFAULT "yes",
        smtp_server             varchar(200)                    not null,
        smtp_port               varchar(5)                      not null DEFAULT "587",
        smtp_encryption         varchar(20)                     not null DEFAULT "starttls",
        smtp_auth               varchar(20)                     not null DEFAULT "plaintext",
        smtp_auth_identity      varchar(20)                     not null DEFAULT "%s",
        smtp_default            varchar(5)                      not null DEFAULT "yes",
        smtp_refresh_ttl        varchar(5)                      not null DEFAULT "6",
        imap_enabled            varchar(5)                      not null DEFAULT "yes",
        imap_server             varchar(200)                    not null,
        imap_port               varchar(5)                      not null DEFAULT "143",
        imap_encryption         varchar(20)                     not null DEFAULT "starttls",
        imap_auth               varchar(20)                     not null DEFAULT "plaintext",
        imap_auth_identity      varchar(20)                     not null DEFAULT "%s",
        imap_refresh_ttl        varchar(5)                      not null DEFAULT "6",
        pop_enabled             varchar(5)                      not null DEFAULT "yes",
        pop_server              varchar(200)                    not null,
        pop_port                varchar(5)                      not null DEFAULT "110",
        pop_encryption          varchar(20)                     not null DEFAULT "starttls",
        pop_auth                varchar(20)                     not null DEFAULT "plaintext",
        pop_auth_identity       varchar(20)                     not null DEFAULT "%s",
        pop_refresh_ttl         varchar(5)                      not null DEFAULT "6"
);

