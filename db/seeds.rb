# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Theme.delete_all
Theme.create(:code => "turningpoint")
Theme.create(:code => "heartful")
Theme.create(:code => "firsttime")
Theme.create(:code => "dangerous")
Theme.create(:code => "funny")

Vihicle.delete_all
Vihicle.create(:code => "walk")

Member.delete_all
Member.create(:code => "man")

Purpose.delete_all
Purpose.create(:code => "sightseeing")

Budget.delete_all
Budget.create(:code => "poor")

Language.delete_all
Language.create(:code => "no_english_no_local")

Age.delete_all
Age.create(:code => "teenager")

AboutUs.delete_all
AboutUs.create(:content => "ここに旅レポについて書く")

# admin user
# User.create(
#   :email => 'tabirepo.analytics@gmail.com', 
#   :password => 'PE9593Yk',
#   :user_type => "1"
#   )