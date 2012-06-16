# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# INSERT INTO "users" ("created_at", "last_seen_at", "name", "twitter_uid", "updated_at", "username") VALUES (?, ?, ?, ?, ?, ?)  [["created_at", Sat, 16 Jun 2012 00:27:11 UTC +00:00], ["last_seen_at", nil], ["name", "Zack Gilbert"], ["twitter_uid", "822454"], ["updated_at", Sat, 16 Jun 2012 00:27:11 UTC +00:00], ["username", "zackgilbert"]]
User.create(name: "Zack Gilbert", twitter_uid: "822454", username: "zackgilbert", last_seen_at: Time.now) if User.all.count < 1
