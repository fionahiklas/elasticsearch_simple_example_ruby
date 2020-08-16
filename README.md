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

### Install Ruby Dependencies

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



### Populate Elastic search with data

Run the load script as follows

```
bundle exec ./load_data.rb -f vehicles-reduceddata.csv -e http://localhost:9200 > run.log 2>&1 
```




## Notes

### Elasticsearch

#### Get a count of the number of entries

```
curl http://localhost:9200/vehicle/_count
```



#### Retrieve simple search 

```
curl http://localhost:9200/vehicle/_search?q=*MW*
```



### Ruby

#### Connecting to Elastic Search

For a local ES listening on `localhost:9200`

```
irb:> require 'elasticsearch'
irb:> client = Elasticsearch::Client.new log: true
```

The output is quite verbose since the client object contains alot of information


#### Indexing a document

For a very simple document (with no ID) the following will add it to the index

```
irb:> client.index index: "fred", body: { "jim": "sheila" }

2020-08-16 21:46:35 +0100: POST http://localhost:9200/fred/_doc [status:201, request:2.046s, query:n/a]
2020-08-16 21:46:35 +0100: > {"jim":"sheila"}
2020-08-16 21:46:35 +0100: < {"_index":"fred","_type":"_doc","_id":"uEkG-XMBVCVLpJUSH2yW","_version":1,"result":"created","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":0,"_primary_term":1}
=> {"_index"=>"fred", "_type"=>"_doc", "_id"=>"uEkG-XMBVCVLpJUSH2yW", "_version"=>1, "result"=>"created", "_shards"=>{"total"=>2, "successful"=>1, "failed"=>0}, "_seq_no"=>0, "_primary_term"=>1}
```




## References

### Elasticsearch

* [Docker image](https://hub.docker.com/_/elasticsearch)
* [Elasticsearch Ruby github](https://github.com/elastic/elasticsearch-ruby)


### Ruby

* [Elasticsearch gem](https://rubygems.org/gems/elasticsearch/versions/7.8.1)
* [Elasticsearch API](https://www.rubydoc.info/gems/elasticsearch-api/Elasticsearch)
* [Iterating two arrays at once](https://stackoverflow.com/questions/3580049/whats-the-ruby-way-to-iterate-over-two-arrays-at-once)

