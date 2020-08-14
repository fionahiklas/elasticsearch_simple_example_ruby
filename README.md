# elasticsearch_simple_example_ruby

## Getting Started
 
### Run ElasticSearch 

Using Docker run the following commands

```
docker network create elasticnetwork

docker run -d --name elasticsearch --net elasticnetwork -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:7.8.1
```

Check that it's working

```
curl http://localhost:9200/?pretty
{
  "name" : "82ea953363ed",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "jOOfem8wQvSymi_xUCHozw",
  "version" : {
    "number" : "7.8.1",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "b5ca9c58fb664ca8bf9e4057fc229b3396bf3a89",
    "build_date" : "2020-07-21T16:40:44.668009Z",
    "build_snapshot" : false,
    "lucene_version" : "8.5.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

### Install Bundler

Setup path for ruby gems

```
export USER_GEMS=`gem env | grep USER | sed -e 's/^.*\(\/home.*\)$/\1/'`
export PATH=$PATH:$USER_GEMS/bin
```

Install bundler

```
gem install bundler --user-install

```

Install dependencies for this project 

```
bundle install --path vendor
```




## Notes

### Elasticsearch

* [Docker image](https://hub.docker.com/_/elasticsearch)


### Ruby

* [Elastic search gem](https://rubygems.org/gems/elasticsearch/versions/7.8.1)



