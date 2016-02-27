# Oceanus

Docker implementation with Ruby.
Depending on LXC.

## Installation

```ruby
gem 'oceanus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oceanus

## Usage

```sh
$ oceanus pull {image}:{tag}
$ oceanus ps
$ oceanus run {image}
$ oceanus exec {image} {command}
$ oceanus logs {container_id}
$ oceanus images
$ oceanus rm {container_id}
$ oceanus rmi {image_id}
$ oceanus stop {container_id}
$ oceanus build -t {image}:{tag} {directory_path_of_Dockerfile}
```

- [x] pull
- [x] ps
- [x] run
- [x] exec
- [ ] logs
- [x] images
- [x] rm
- [x] rmi
- [x] stop
- [ ] build
- [x] commit

## Contributing

1. Fork it ( https://github.com/[my-github-username]/oceanus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
