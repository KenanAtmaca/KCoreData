# KCoreData
İOS Basic Core Data Class

```Swift
var kcdata = KCoreData(entityName: "User")
```

- Insert value Core Data database

```Swift
kcdata.insert(data: ["name":"eric" as AnyObject])
```

- Fetch value in Core Data database

```Swift
var items = [NSManagedObject]()

 items = kcdata.fetch()
        
        for itm in items {
            print(itm.value(forKey: "name")!)
        }

```

```Swift
print(kcdata.fetchValues(key: "name")) // names
```
- Fetch with predicate

- [Doc predicate](https://realm.io/news/nspredicate-cheatsheet/)

```Swift
items = kcdata.sortFetch(predicate: "name CONTAINS[c] 'al'", ascending: nil, key: nil)
        
        for itm in items {
            print(itm.value(forKey: "name")!)
        }
```

- Update value Core Data database

```Swift
   kcdata.update(predicate: "name == 'defne'", value: "mahmut" as AnyObject, key: "name")
```

- Delete value Core Data database

```Swift
   kcdata.delete(predicate: "name == 'david'")
```

