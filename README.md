# chef-iptables-persistent

## Description

An ip(6)tables rules loading cookbook relying on the iptables-persistent package functionality that restores the IPv4 and IPv6 iptables rules from two files stored in */etc/iptables/* on startup.

## Usage

Add the iptables-persistent::default target to the runlist and overwrite the *rules* and *rules.v6* in the cookbook's files directory (or via an overlay site-cookbooks directory that leaves the original files untouched). 

## Requirements

### Platform

It should work on all OSes that provide a iptables-persistent package which currently are Debian and all derivates like Mint, Ubuntu, etc.

## Recipes

### default

There exists only one recipe, use this.

## License

chef-iptables-persistent is licensed under the Apache License, Version 2.0. See LICENSE for more information.
