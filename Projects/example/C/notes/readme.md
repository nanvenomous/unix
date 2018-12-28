# Storage Classes

Tell the compiler how to store the subsequent variable

| Keyword | Storage | Initial Value | Scope | Life |
|---|---|---|---|---|
| auto | memory | unpredictable | local | within the block |
| register | CPU registers | garbage | local | within the block |
| static | memory | 0 | local | across function calls |
| extern | memory | 0 | global | program life |

Note: typedef is also technically a storage class

For more information see [explanation and usage](http://cs-fundamentals.com/c-programming/storage-classes-in-c-and-storage-class-specifiers.php)
