source(file="iniparser.r")
source(file="library.r")

library(RPostgreSQL)

Cluster.getConnection <- function(cluster, group)
{
    if (!exists('.connection', where=.GlobalEnv)) {
        driver <- dbDriver("PostgreSQL")
        
        .connection <<- dbConnect(dbConnect(
            driver,
            host = cluster$host,
            port = cluster$port,
            dbname = cluster$dbname,
            user = cluster$user,
            password = cluster$pass
        ), group=group)
    }
    
    return(.connection)
}

Cluster.getUsers <- function()
{
    clusterConfig <- Cluster.getConfig()
    cluster <- clusterConfig$cluster
    
    connection <- Cluster.getConnection(cluster, "test")
    
    if (!file.exists("data/users.rds")) {
        users <- dbGetQuery(
            connection, 
            sprintf(
                "select * from %s.%s limit 100", 
                clusterConfig$schema$name, 
                clusterConfig$table$users
                )
            )
        
        View(users)
        
        saveRDS(users, "data/users.rds")
    } else {
        users <- readRDS("data/users.rds")   
    }
    
    return(users)
}

Cluster.getConfig <- function()
{
    return (Parse.INI("cluster.ini"))
}