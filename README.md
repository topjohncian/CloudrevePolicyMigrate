~~求求你了给我点个 `Star` 和 `Follow` 把~~
## CloudrevePolicyMigrate
此工具可以帮您将 Cloudreve 中策略内的文件和文件夹迁移到另一个策略

**此工具仅修改数据表**
# 此工具缺少测试 使用前一定要备份数据库

## 使用场景
OneDrive世纪互联策略（简称A）翻车了，把A里的文件全部搬迁到了 OneDrive国际版策略（简称B）

但此时 Cloudreve 里的文件仍指向A

此工具可以帮您把 Cloudreve 内的文件指向B 

## 使用方法
### 准备

> 注：下文将需要搬迁策略称为 **A**，ID为 `1`
>
> 搬迁后的策略称为 **B**，ID为 `2`
# 使用前一定要备份数据库
创建B策略，并把B中的 `存储路径` 和 `存储文件名` 设置成与A相同

然后将A策略内的所有内容拷贝到B策略内 （必须要保证文件结构正确）
### 1. 下载

在 [Action](https://github.com/topjohncian/CloudrevePolicyMigrate/actions/runs/377209844) 里的 `Artifacts` 下载对应版本的可执行文件

将其放在与 Cloudreve 的配置(conf.ini)同级目录下

### 2.迁移

在目录下执行 `./第一步下载的可执行文件 [A策略的ID] [B策略的ID]` 如
```shell script
./cloudreve_policy_migrate_linux_amd64 1 2
```

**Pro用户需要在命令后增加 -pro** 如：
```shell script
./cloudreve_policy_migrate_linux_amd64 1 2 -pro 
```