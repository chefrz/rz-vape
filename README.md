![image](https://cdn.discordapp.com/attachments/1186357096216801381/1205589803878326353/VAPE.png?ex=65d8ec00&is=65c67700&hm=86b756bcc5f6cd50a98c5df3b98f897bd35dcc309dfeaeb333f8649af13924bb&)

# rz-vape
- Vape Script [QBCORE]
- New QBCore

## Showcase
- https://youtu.be/SVM-ORQwK_I
## Discord
- https://discord.gg/3JHgCdUFtG

## Update
- You use vape from now on, your stress will decrease and updated the setup lines

## Features
- Basic Config
- Low Resmon
- Item Vape

## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)

## Installation

- Add the vape item image to `qb-inventory/html/images`
- Add the vape item to `qb-core/shared/items`

```
vape = { name = 'vape', label = 'Vape', weight = 100, type = 'item', image = 'vape.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Hmm...' },
```

- Add the vape item to `qb-shops/config/Config.Products.normal`
```
{name = 'vape', price = 2,   amount = 500, info = {}, type = 'item'},
```
- Download the script and put it in the `[qb]` directory.
- Add the following code to your server.cfg/resouces.cfg
```
ensure rz-vape
```
