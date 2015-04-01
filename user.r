source(file="cluster.r")

users <- Cluster.getUsers()
clusterConfig <- Cluster.getConfig()

fields <- clusterConfig$field_users

sample1000 <- sample(1:nrow(users), 100)
users1000 <- users[sample1000,]

sample2pct <- runif(nrow(users)) <= 0.02
users2pct <- users[sample2pct,]

users2pct <- subset(
    users,
    subset = sample2pct,
    select = c(user_id, as.name(fields$country), as.name(fields$tester))
)

str(users2pct)

sum(sample2pct)/nrow(users)

users0 <- rbind(users1000[,names(users2pct)], users2pct)

dups <- duplicated(users0$user_id)
users1 <- users0[!dups,]

nrow(users0)
nrow(users1)

es_au_nontest <- (users1$as.name(fields.country) == "ES" |
                           users1$as.name(fields.country) == "AU") &
    users1$is_tester==FALSE

users2 <- users1[which(es_au_nontest),]
