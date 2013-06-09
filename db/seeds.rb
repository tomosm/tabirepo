# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Theme.delete_all
Theme.create(:code => "turningpoint", :value => "人生を変えた話", :color => "#365197")
Theme.create(:code => "heartful", :value => "心温まる話", :color => "#e6443e")
Theme.create(:code => "firsttime", :value => "初体験の話", :color => "#874e91")
Theme.create(:code => "dangerous", :value => "危ない話", :color => "#faca33")
Theme.create(:code => "funny", :value => "すべらない話", :color => "#469956")

Vihicle.delete_all
Vihicle.create(:code => "walk", :value => "徒歩")
Vihicle.create(:code => "bike", :value => "自転車")
Vihicle.create(:code => "bus", :value => "バス")
Vihicle.create(:code => "taxi", :value => "タクシー")
Vihicle.create(:code => "rental", :value => "レンタカー・レンタルバイク")
Vihicle.create(:code => "train", :value => "鉄道")
Vihicle.create(:code => "plane", :value => "飛行機")
Vihicle.create(:code => "boat", :value => "ボート")
Vihicle.create(:code => "ship", :value => "船")
Vihicle.create(:code => "animal", :value => "動物（ラクダ、ゾウなど）")
Vihicle.create(:code => "traditional", :value => "ご当地乗り物（リキシャ、トゥクトゥクなど）")
Vihicle.create(:code => "etc", :value => "その他")

Member.delete_all
Member.create(:code => "man", :value => "一人旅(男)")
Member.create(:code => "woman", :value => "一人旅(女)")
Member.create(:code => "men", :value => "二人旅(男x男)")
Member.create(:code => "women", :value => "二人旅(女x女)")
Member.create(:code => "mix", :value => "二人旅（男×女）（カップル、夫婦以外）")
Member.create(:code => "couple", :value => "カップル、夫婦")
Member.create(:code => "group", :value => "グループ旅行（数名）")
Member.create(:code => "tour", :value => "団体旅行（数十名）")
Member.create(:code => "etc", :value => "その他")

Purpose.delete_all
Purpose.create(:code => "sightseeing", :value => "観光")
Purpose.create(:code => "wanderer", :value => "放浪、世界一周")
Purpose.create(:code => "volunteer", :value => "ボランティア")
Purpose.create(:code => "workingholiday", :value => "ワーキングホリデー")
Purpose.create(:code => "studyabroad", :value => "留学")
Purpose.create(:code => "transfer", :value => "転勤")
Purpose.create(:code => "immigration", :value => "永住、移住")
Purpose.create(:code => "peaceboat", :value => "ピースボート")
Purpose.create(:code => "etc", :value => "その他")


Budget.delete_all
Budget.create(:code => "poor", :value => "貧乏旅行（バックパッカー、安宿）")
Budget.create(:code => "normal", :value => "普通旅行（国内旅行と同じ感覚）")
Budget.create(:code => "rich", :value => "豪華旅行（高級ホテル、リゾートなど）")
Budget.create(:code => "etc", :value => "その他")

Language.delete_all
Language.create(:code => "no_english_no_local", :value => "英語×、現地語×")
Language.create(:code => "no_english_little_local", :value => "英語×、現地語△")
Language.create(:code => "no_english_good_local", :value => "英語×、現地語○")
Language.create(:code => "little_english_no_local", :value => "英語△、現地語△")
Language.create(:code => "little_english_little_local", :value => "英語△、現地語×")
Language.create(:code => "little_english_good_local", :value => "英語△、現地語○")
Language.create(:code => "good_english_no_local", :value => "英語○、現地語×")
Language.create(:code => "good_english_little_local", :value => "英語○、現地語△")
Language.create(:code => "good_english_good_local", :value => "英語○、現地語○")
Language.create(:code => "etc", :value => "その他")


Age.delete_all
Age.create(:code => "teenager", :value => "～19歳")
Age.create(:code => "early_twenties", :value => "20～24歳")
Age.create(:code => "late_teenager", :value => "25～29歳")
Age.create(:code => "early_thirties", :value => "30～34歳")
Age.create(:code => "late_teenager", :value => "35～39歳")
Age.create(:code => "fourties", :value => "40代")
Age.create(:code => "fifties", :value => "50代")
Age.create(:code => "teenager", :value => "60代以上")

Country.delete_all
Country.create(:code => 'ISL', :value => 'アイスランド')
Country.create(:code => 'IRL', :value => 'アイルランド')
Country.create(:code => 'AZE', :value => 'アゼルバイジャン')
Country.create(:code => 'AFG', :value => 'アフガニスタン')
Country.create(:code => 'USA', :value => 'アメリカ合衆国')
Country.create(:code => 'VIR', :value => 'アメリカ領ヴァージン諸島')
Country.create(:code => 'ASM', :value => 'アメリカ領サモア')
Country.create(:code => 'ARE', :value => 'アラブ首長国連邦')
Country.create(:code => 'DZA', :value => 'アルジェリア')
Country.create(:code => 'ARG', :value => 'アルゼンチン')
Country.create(:code => 'ABW', :value => 'アルバ')
Country.create(:code => 'ALB', :value => 'アルバニア')
Country.create(:code => 'ARM', :value => 'アルメニア')
Country.create(:code => 'AIA', :value => 'アンギラ')
Country.create(:code => 'AGO', :value => 'アンゴラ')
Country.create(:code => 'ATG', :value => 'アンティグア・バーブーダ')
Country.create(:code => 'AND', :value => 'アンドラ')
Country.create(:code => 'YEM', :value => 'イエメン')
Country.create(:code => 'GBR', :value => 'イギリス')
Country.create(:code => 'IOT', :value => 'イギリス領インド洋地域')
Country.create(:code => 'VGB', :value => 'イギリス領ヴァージン諸島')
Country.create(:code => 'ISR', :value => 'イスラエル')
Country.create(:code => 'ITA', :value => 'イタリア')
Country.create(:code => 'IRQ', :value => 'イラク')
Country.create(:code => 'IRN', :value => 'イラン・イスラム共和国')
Country.create(:code => 'IND', :value => 'インド')
Country.create(:code => 'IDN', :value => 'インドネシア')
Country.create(:code => 'WLF', :value => 'ウォリス・フツナ')
Country.create(:code => 'UGA', :value => 'ウガンダ')
Country.create(:code => 'UKR', :value => 'ウクライナ')
Country.create(:code => 'UZB', :value => 'ウズベキスタン')
Country.create(:code => 'URY', :value => 'ウルグアイ')
Country.create(:code => 'ECU', :value => 'エクアドル')
Country.create(:code => 'EGY', :value => 'エジプト')
Country.create(:code => 'EST', :value => 'エストニア')
Country.create(:code => 'ETH', :value => 'エチオピア')
Country.create(:code => 'ERI', :value => 'エリトリア')
Country.create(:code => 'SLV', :value => 'エルサルバドル')
Country.create(:code => 'AUS', :value => 'オーストラリア')
Country.create(:code => 'AUT', :value => 'オーストリア')
Country.create(:code => 'ALA', :value => 'オーランド諸島')
Country.create(:code => 'OMN', :value => 'オマーン')
Country.create(:code => 'NLD', :value => 'オランダ')
Country.create(:code => 'GHA', :value => 'ガーナ')
Country.create(:code => 'CPV', :value => 'カーボベルデ')
Country.create(:code => 'GGY', :value => 'ガーンジー')
Country.create(:code => 'GUY', :value => 'ガイアナ')
Country.create(:code => 'KAZ', :value => 'カザフスタン')
Country.create(:code => 'QAT', :value => 'カタール')
Country.create(:code => 'UMI', :value => '合衆国領有小離島')
Country.create(:code => 'CAN', :value => 'カナダ')
Country.create(:code => 'GAB', :value => 'ガボン')
Country.create(:code => 'CMR', :value => 'カメルーン')
Country.create(:code => 'GMB', :value => 'ガンビア')
Country.create(:code => 'KHM', :value => 'カンボジア')
Country.create(:code => 'MNP', :value => '北マリアナ諸島')
Country.create(:code => 'GIN', :value => 'ギニア')
Country.create(:code => 'GNB', :value => 'ギニアビサウ')
Country.create(:code => 'CYP', :value => 'キプロス')
Country.create(:code => 'CUB', :value => 'キューバ')
Country.create(:code => 'CUW', :value => 'キュラソー')
Country.create(:code => 'GRC', :value => 'ギリシャ')
Country.create(:code => 'KIR', :value => 'キリバス')
Country.create(:code => 'KGZ', :value => 'キルギス')
Country.create(:code => 'GTM', :value => 'グアテマラ')
Country.create(:code => 'GLP', :value => 'グアドループ')
Country.create(:code => 'GUM', :value => 'グアム')
Country.create(:code => 'KWT', :value => 'クウェート')
Country.create(:code => 'COK', :value => 'クック諸島')
Country.create(:code => 'GRL', :value => 'グリーンランド')
Country.create(:code => 'CXR', :value => 'クリスマス島')
Country.create(:code => 'GEO', :value => 'グルジア')
Country.create(:code => 'GRD', :value => 'グレナダ')
Country.create(:code => 'HRV', :value => 'クロアチア')
Country.create(:code => 'CYM', :value => 'ケイマン諸島')
Country.create(:code => 'KEN', :value => 'ケニア')
Country.create(:code => 'CIV', :value => 'コートジボワール')
Country.create(:code => 'CCK', :value => 'ココス（キーリング）諸島')
Country.create(:code => 'CRI', :value => 'コスタリカ')
Country.create(:code => 'COM', :value => 'コモロ')
Country.create(:code => 'COL', :value => 'コロンビア')
Country.create(:code => 'COG', :value => 'コンゴ共和国')
Country.create(:code => 'COD', :value => 'コンゴ民主共和国')
Country.create(:code => 'SAU', :value => 'サウジアラビア')
Country.create(:code => 'SGS', :value => 'サウスジョージア・サウスサンドウィッチ諸島')
Country.create(:code => 'WSM', :value => 'サモア')
Country.create(:code => 'STP', :value => 'サントメ・プリンシペ')
Country.create(:code => 'BLM', :value => 'サン・バルテルミー')
Country.create(:code => 'ZMB', :value => 'ザンビア')
Country.create(:code => 'SPM', :value => 'サンピエール島・ミクロン島')
Country.create(:code => 'SMR', :value => 'サンマリノ')
Country.create(:code => 'MAF', :value => 'サン・マルタン（フランス領）')
Country.create(:code => 'SLE', :value => 'シエラレオネ')
Country.create(:code => 'DJI', :value => 'ジブチ')
Country.create(:code => 'GIB', :value => 'ジブラルタル')
Country.create(:code => 'JEY', :value => 'ジャージー')
Country.create(:code => 'JAM', :value => 'ジャマイカ')
Country.create(:code => 'SYR', :value => 'シリア・アラブ共和国')
Country.create(:code => 'SGP', :value => 'シンガポール')
Country.create(:code => 'SXM', :value => 'シント・マールテン（オランダ領）')
Country.create(:code => 'ZWE', :value => 'ジンバブエ')
Country.create(:code => 'CHE', :value => 'スイス')
Country.create(:code => 'SWE', :value => 'スウェーデン')
Country.create(:code => 'SDN', :value => 'スーダン')
Country.create(:code => 'SJM', :value => 'スヴァールバル諸島およびヤンマイエン島')
Country.create(:code => 'ESP', :value => 'スペイン')
Country.create(:code => 'SUR', :value => 'スリナム')
Country.create(:code => 'LKA', :value => 'スリランカ')
Country.create(:code => 'SVK', :value => 'スロバキア')
Country.create(:code => 'SVN', :value => 'スロベニア')
Country.create(:code => 'SWZ', :value => 'スワジランド')
Country.create(:code => 'SYC', :value => 'セーシェル')
Country.create(:code => 'GNQ', :value => '赤道ギニア')
Country.create(:code => 'SEN', :value => 'セネガル')
Country.create(:code => 'SRB', :value => 'セルビア')
Country.create(:code => 'KNA', :value => 'セントクリストファー・ネイビス')
Country.create(:code => 'VCT', :value => 'セントビンセントおよびグレナディーン諸島')
Country.create(:code => 'SHN', :value => 'セントヘレナ・アセンションおよびトリスタンダクーニャ')
Country.create(:code => 'LCA', :value => 'セントルシア')
Country.create(:code => 'SOM', :value => 'ソマリア')
Country.create(:code => 'SLB', :value => 'ソロモン諸島')
Country.create(:code => 'TCA', :value => 'タークス・カイコス諸島')
Country.create(:code => 'THA', :value => 'タイ')
Country.create(:code => 'KOR', :value => '大韓民国')
Country.create(:code => 'TWN', :value => '台湾（台湾省/中華民国）')
Country.create(:code => 'TJK', :value => 'タジキスタン')
Country.create(:code => 'TZA', :value => 'タンザニア')
Country.create(:code => 'CZE', :value => 'チェコ')
Country.create(:code => 'TCD', :value => 'チャド')
Country.create(:code => 'CAF', :value => '中央アフリカ共和国')
Country.create(:code => 'CHN', :value => '中国')
Country.create(:code => 'TUN', :value => 'チュニジア')
Country.create(:code => 'PRK', :value => '朝鮮民主主義人民共和国')
Country.create(:code => 'CHL', :value => 'チリ')
Country.create(:code => 'TUV', :value => 'ツバル')
Country.create(:code => 'DNK', :value => 'デンマーク')
Country.create(:code => 'DEU', :value => 'ドイツ')
Country.create(:code => 'TGO', :value => 'トーゴ')
Country.create(:code => 'TKL', :value => 'トケラウ')
Country.create(:code => 'DOM', :value => 'ドミニカ共和国')
Country.create(:code => 'DMA', :value => 'ドミニカ国')
Country.create(:code => 'TTO', :value => 'トリニダード・トバゴ')
Country.create(:code => 'TKM', :value => 'トルクメニスタン')
Country.create(:code => 'TUR', :value => 'トルコ')
Country.create(:code => 'TON', :value => 'トンガ')
Country.create(:code => 'NGA', :value => 'ナイジェリア')
Country.create(:code => 'NRU', :value => 'ナウル')
Country.create(:code => 'NAM', :value => 'ナミビア')
Country.create(:code => 'ATA', :value => '南極')
Country.create(:code => 'NIU', :value => 'ニウエ')
Country.create(:code => 'NIC', :value => 'ニカラグア')
Country.create(:code => 'NER', :value => 'ニジェール')
Country.create(:code => 'JPN', :value => '日本')
Country.create(:code => 'ESH', :value => '西サハラ')
Country.create(:code => 'NCL', :value => 'ニューカレドニア')
Country.create(:code => 'NZL', :value => 'ニュージーランド')
Country.create(:code => 'NPL', :value => 'ネパール')
Country.create(:code => 'NFK', :value => 'ノーフォーク島')
Country.create(:code => 'NOR', :value => 'ノルウェー')
Country.create(:code => 'HMD', :value => 'ハード島とマクドナルド諸島')
Country.create(:code => 'BHR', :value => 'バーレーン')
Country.create(:code => 'HTI', :value => 'ハイチ')
Country.create(:code => 'PAK', :value => 'パキスタン')
Country.create(:code => 'VAT', :value => 'バチカン市国')
Country.create(:code => 'PAN', :value => 'パナマ')
Country.create(:code => 'VUT', :value => 'バヌアツ')
Country.create(:code => 'BHS', :value => 'バハマ')
Country.create(:code => 'PNG', :value => 'パプアニューギニア')
Country.create(:code => 'BMU', :value => 'バミューダ')
Country.create(:code => 'PLW', :value => 'パラオ')
Country.create(:code => 'PRY', :value => 'パラグアイ')
Country.create(:code => 'BRB', :value => 'バルバドス')
Country.create(:code => 'PSE', :value => 'パレスチナ')
Country.create(:code => 'HUN', :value => 'ハンガリー')
Country.create(:code => 'BGD', :value => 'バングラデシュ')
Country.create(:code => 'TLS', :value => '東ティモール')
Country.create(:code => 'PCN', :value => 'ピトケアン')
Country.create(:code => 'FJI', :value => 'フィジー')
Country.create(:code => 'PHL', :value => 'フィリピン')
Country.create(:code => 'FIN', :value => 'フィンランド')
Country.create(:code => 'BTN', :value => 'ブータン')
Country.create(:code => 'BVT', :value => 'ブーベ島')
Country.create(:code => 'PRI', :value => 'プエルトリコ')
Country.create(:code => 'FRO', :value => 'フェロー諸島')
Country.create(:code => 'FLK', :value => 'フォークランド（マルビナス）諸島')
Country.create(:code => 'BRA', :value => 'ブラジル')
Country.create(:code => 'FRA', :value => 'フランス')
Country.create(:code => 'GUF', :value => 'フランス領ギアナ')
Country.create(:code => 'PYF', :value => 'フランス領ポリネシア')
Country.create(:code => 'ATF', :value => 'フランス領南方・南極地域')
Country.create(:code => 'BGR', :value => 'ブルガリア')
Country.create(:code => 'BFA', :value => 'ブルキナファソ')
Country.create(:code => 'BRN', :value => 'ブルネイ・ダルサラーム')
Country.create(:code => 'BDI', :value => 'ブルンジ')
Country.create(:code => 'VNM', :value => 'ベトナム')
Country.create(:code => 'BEN', :value => 'ベナン')
Country.create(:code => 'VEN', :value => 'ベネズエラ・ボリバル共和国')
Country.create(:code => 'BLR', :value => 'ベラルーシ')
Country.create(:code => 'BLZ', :value => 'ベリーズ')
Country.create(:code => 'PER', :value => 'ペルー')
Country.create(:code => 'BEL', :value => 'ベルギー')
Country.create(:code => 'POL', :value => 'ポーランド')
Country.create(:code => 'BIH', :value => 'ボスニア・ヘルツェゴビナ')
Country.create(:code => 'BWA', :value => 'ボツワナ')
Country.create(:code => 'BES', :value => 'ボネール、シント・ユースタティウスおよびサバ')
Country.create(:code => 'BOL', :value => 'ボリビア多民族国')
Country.create(:code => 'PRT', :value => 'ポルトガル')
Country.create(:code => 'HKG', :value => '香港')
Country.create(:code => 'HND', :value => 'ホンジュラス')
Country.create(:code => 'MHL', :value => 'マーシャル諸島')
Country.create(:code => 'MAC', :value => 'マカオ')
Country.create(:code => 'MKD', :value => 'マケドニア旧ユーゴスラビア共和国')
Country.create(:code => 'MDG', :value => 'マダガスカル')
Country.create(:code => 'MYT', :value => 'マヨット')
Country.create(:code => 'MWI', :value => 'マラウイ')
Country.create(:code => 'MLI', :value => 'マリ')
Country.create(:code => 'MLT', :value => 'マルタ')
Country.create(:code => 'MTQ', :value => 'マルティニーク')
Country.create(:code => 'MYS', :value => 'マレーシア')
Country.create(:code => 'IMN', :value => 'マン島')
Country.create(:code => 'FSM', :value => 'ミクロネシア連邦')
Country.create(:code => 'ZAF', :value => '南アフリカ')
Country.create(:code => 'SSD', :value => '南スーダン')
Country.create(:code => 'MMR', :value => 'ミャンマー')
Country.create(:code => 'MEX', :value => 'メキシコ')
Country.create(:code => 'MUS', :value => 'モーリシャス')
Country.create(:code => 'MRT', :value => 'モーリタニア')
Country.create(:code => 'MOZ', :value => 'モザンビーク')
Country.create(:code => 'MCO', :value => 'モナコ')
Country.create(:code => 'MDV', :value => 'モルディブ')
Country.create(:code => 'MDA', :value => 'モルドバ共和国')
Country.create(:code => 'MAR', :value => 'モロッコ')
Country.create(:code => 'MNG', :value => 'モンゴル')
Country.create(:code => 'MNE', :value => 'モンテネグロ')
Country.create(:code => 'MSR', :value => 'モントセラト')
Country.create(:code => 'JOR', :value => 'ヨルダン')
Country.create(:code => 'LAO', :value => 'ラオス人民民主共和国')
Country.create(:code => 'LVA', :value => 'ラトビア')
Country.create(:code => 'LTU', :value => 'リトアニア')
Country.create(:code => 'LBY', :value => 'リビア')
Country.create(:code => 'LIE', :value => 'リヒテンシュタイン')
Country.create(:code => 'LBR', :value => 'リベリア')
Country.create(:code => 'ROU', :value => 'ルーマニア')
Country.create(:code => 'LUX', :value => 'ルクセンブルク')
Country.create(:code => 'RWA', :value => 'ルワンダ')
Country.create(:code => 'LSO', :value => 'レソト')
Country.create(:code => 'LBN', :value => 'レバノン')
Country.create(:code => 'REU', :value => 'レユニオン')
Country.create(:code => 'RUS', :value => 'ロシア連邦')

AboutUs.delete_all
AboutUs.create(:content => "ここに旅レポについて書く")

# admin user
# User.create(
    :user_name => 'admin@tabi-repo.net',
    :password => '7NSAAEAA'
#   :email => 'admin@tabi-repo.net', 
#   :user_type => "1"
#   )