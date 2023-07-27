// TODO(spydon): Convert these to use vector_math
class Vector2f {
  double x;
  double y;

  Vector2f(this.x, this.y);
}

class Vector3f {
  double x;
  double y;
  double z;

  Vector3f(this.x, this.y, this.z);
}

class Float2 {
  final double x;
  final double y;

  const Float2(this.x, this.y);
}

class Float3 {
  final double x;
  final double y;
  final double z;

  const Float3(this.x, this.y, this.z);
}

const List<Float2> gradient2d = <Float2>[
  Float2(-1.0, -1.0),
  Float2(1.0, -1.0),
  Float2(-1.0, 1.0),
  Float2(1.0, 1.0),
  Float2(0.0, -1.0),
  Float2(-1.0, 0.0),
  Float2(0.0, 1.0),
  Float2(1.0, 0.0),
];

const List<Float3> gradient3d = <Float3>[
  Float3(1.0, 1.0, 0.0),
  Float3(-1.0, 1.0, 0.0),
  Float3(1.0, -1.0, 0.0),
  Float3(-1.0, -1.0, 0.0),
  Float3(1.0, 0.0, 1.0),
  Float3(-1.0, 0.0, 1.0),
  Float3(1.0, 0.0, -1.0),
  Float3(-1.0, 0.0, -1.0),
  Float3(0.0, 1.0, 1.0),
  Float3(0.0, -1.0, 1.0),
  Float3(0.0, 1.0, -1.0),
  Float3(0.0, -1.0, -1.0),
  Float3(1.0, 1.0, 0.0),
  Float3(0.0, -1.0, 1.0),
  Float3(-1.0, 1.0, 0.0),
  Float3(0.0, -1.0, -1.0),
];

const List<Float2> cell2d = <Float2>[
  Float2(-0.4313539279, 0.1281943404),
  Float2(-0.1733316799, 0.415278375),
  Float2(-0.2821957395, -0.3505218461),
  Float2(-0.2806473808, 0.3517627718),
  Float2(0.3125508975, -0.3237467165),
  Float2(0.3383018443, -0.2967353402),
  Float2(-0.4393982022, -0.09710417025),
  Float2(-0.4460443703, -0.05953502905),
  Float2(-0.302223039, 0.3334085102),
  Float2(-0.212681052, -0.3965687458),
  Float2(-0.2991156529, 0.3361990872),
  Float2(0.2293323691, 0.3871778202),
  Float2(0.4475439151, -0.04695150755),
  Float2(0.1777518, 0.41340573),
  Float2(0.1688522499, -0.4171197882),
  Float2(-0.0976597166, 0.4392750616),
  Float2(0.08450188373, 0.4419948321),
  Float2(-0.4098760448, -0.1857461384),
  Float2(0.3476585782, -0.2857157906),
  Float2(-0.3350670039, -0.30038326),
  Float2(0.2298190031, -0.3868891648),
  Float2(-0.01069924099, 0.449872789),
  Float2(-0.4460141246, -0.05976119672),
  Float2(0.3650293864, 0.2631606867),
  Float2(-0.349479423, 0.2834856838),
  Float2(-0.4122720642, 0.1803655873),
  Float2(-0.267327811, 0.3619887311),
  Float2(0.322124041, -0.3142230135),
  Float2(0.2880445931, -0.3457315612),
  Float2(0.3892170926, -0.2258540565),
  Float2(0.4492085018, -0.02667811596),
  Float2(-0.4497724772, 0.01430799601),
  Float2(0.1278175387, -0.4314657307),
  Float2(-0.03572100503, 0.4485799926),
  Float2(-0.4297407068, -0.1335025276),
  Float2(-0.3217817723, 0.3145735065),
  Float2(-0.3057158873, 0.3302087162),
  Float2(-0.414503978, 0.1751754899),
  Float2(-0.3738139881, 0.2505256519),
  Float2(0.2236891408, -0.3904653228),
  Float2(0.002967775577, -0.4499902136),
  Float2(0.1747128327, -0.4146991995),
  Float2(-0.4423772489, -0.08247647938),
  Float2(-0.2763960987, -0.355112935),
  Float2(-0.4019385906, -0.2023496216),
  Float2(0.3871414161, -0.2293938184),
  Float2(-0.430008727, 0.1326367019),
  Float2(-0.03037574274, -0.4489736231),
  Float2(-0.3486181573, 0.2845441624),
  Float2(0.04553517144, -0.4476902368),
  Float2(-0.0375802926, 0.4484280562),
  Float2(0.3266408905, 0.3095250049),
  Float2(0.06540017593, -0.4452222108),
  Float2(0.03409025829, 0.448706869),
  Float2(-0.4449193635, 0.06742966669),
  Float2(-0.4255936157, -0.1461850686),
  Float2(0.449917292, 0.008627302568),
  Float2(0.05242606404, 0.4469356864),
  Float2(-0.4495305179, -0.02055026661),
  Float2(-0.1204775703, 0.4335725488),
  Float2(-0.341986385, -0.2924813028),
  Float2(0.3865320182, 0.2304191809),
  Float2(0.04506097811, -0.447738214),
  Float2(-0.06283465979, 0.4455915232),
  Float2(0.3932600341, -0.2187385324),
  Float2(0.4472261803, -0.04988730975),
  Float2(0.3753571011, -0.2482076684),
  Float2(-0.273662295, 0.357223947),
  Float2(0.1700461538, 0.4166344988),
  Float2(0.4102692229, 0.1848760794),
  Float2(0.323227187, -0.3130881435),
  Float2(-0.2882310238, -0.3455761521),
  Float2(0.2050972664, 0.4005435199),
  Float2(0.4414085979, -0.08751256895),
  Float2(-0.1684700334, 0.4172743077),
  Float2(-0.003978032396, 0.4499824166),
  Float2(-0.2055133639, 0.4003301853),
  Float2(-0.006095674897, -0.4499587123),
  Float2(-0.1196228124, -0.4338091548),
  Float2(0.3901528491, -0.2242337048),
  Float2(0.01723531752, 0.4496698165),
  Float2(-0.3015070339, 0.3340561458),
  Float2(-0.01514262423, -0.4497451511),
  Float2(-0.4142574071, -0.1757577897),
  Float2(-0.1916377265, -0.4071547394),
  Float2(0.3749248747, 0.2488600778),
  Float2(-0.2237774255, 0.3904147331),
  Float2(-0.4166343106, -0.1700466149),
  Float2(0.3619171625, 0.267424695),
  Float2(0.1891126846, -0.4083336779),
  Float2(-0.3127425077, 0.323561623),
  Float2(-0.3281807787, 0.307891826),
  Float2(-0.2294806661, 0.3870899429),
  Float2(-0.3445266136, 0.2894847362),
  Float2(-0.4167095422, -0.1698621719),
  Float2(-0.257890321, -0.3687717212),
  Float2(-0.3612037825, 0.2683874578),
  Float2(0.2267996491, 0.3886668486),
  Float2(0.207157062, 0.3994821043),
  Float2(0.08355176718, -0.4421754202),
  Float2(-0.4312233307, 0.1286329626),
  Float2(0.3257055497, 0.3105090899),
  Float2(0.177701095, -0.4134275279),
  Float2(-0.445182522, 0.06566979625),
  Float2(0.3955143435, 0.2146355146),
  Float2(-0.4264613988, 0.1436338239),
  Float2(-0.3793799665, -0.2420141339),
  Float2(0.04617599081, -0.4476245948),
  Float2(-0.371405428, -0.2540826796),
  Float2(0.2563570295, -0.3698392535),
  Float2(0.03476646309, 0.4486549822),
  Float2(-0.3065454405, 0.3294387544),
  Float2(-0.2256979823, 0.3893076172),
  Float2(0.4116448463, -0.1817925206),
  Float2(-0.2907745828, -0.3434387019),
  Float2(0.2842278468, -0.348876097),
  Float2(0.3114589359, -0.3247973695),
  Float2(0.4464155859, -0.0566844308),
  Float2(-0.3037334033, -0.3320331606),
  Float2(0.4079607166, 0.1899159123),
  Float2(-0.3486948919, -0.2844501228),
  Float2(0.3264821436, 0.3096924441),
  Float2(0.3211142406, 0.3152548881),
  Float2(0.01183382662, 0.4498443737),
  Float2(0.4333844092, 0.1211526057),
  Float2(0.3118668416, 0.324405723),
  Float2(-0.272753471, 0.3579183483),
  Float2(-0.422228622, -0.1556373694),
  Float2(-0.1009700099, -0.4385260051),
  Float2(-0.2741171231, -0.3568750521),
  Float2(-0.1465125133, 0.4254810025),
  Float2(0.2302279044, -0.3866459777),
  Float2(-0.3699435608, 0.2562064828),
  Float2(0.105700352, -0.4374099171),
  Float2(-0.2646713633, 0.3639355292),
  Float2(0.3521828122, 0.2801200935),
  Float2(-0.1864187807, -0.4095705534),
  Float2(0.1994492955, -0.4033856449),
  Float2(0.3937065066, 0.2179339044),
  Float2(-0.3226158377, 0.3137180602),
  Float2(0.3796235338, 0.2416318948),
  Float2(0.1482921929, 0.4248640083),
  Float2(-0.407400394, 0.1911149365),
  Float2(0.4212853031, 0.1581729856),
  Float2(-0.2621297173, 0.3657704353),
  Float2(-0.2536986953, -0.3716678248),
  Float2(-0.2100236383, 0.3979825013),
  Float2(0.3624152444, 0.2667493029),
  Float2(-0.3645038479, -0.2638881295),
  Float2(0.2318486784, 0.3856762766),
  Float2(-0.3260457004, 0.3101519002),
  Float2(-0.2130045332, -0.3963950918),
  Float2(0.3814998766, -0.2386584257),
  Float2(-0.342977305, 0.2913186713),
  Float2(-0.4355865605, 0.1129794154),
  Float2(-0.2104679605, 0.3977477059),
  Float2(0.3348364681, -0.3006402163),
  Float2(0.3430468811, 0.2912367377),
  Float2(-0.2291836801, -0.3872658529),
  Float2(0.2547707298, -0.3709337882),
  Float2(0.4236174945, -0.151816397),
  Float2(-0.15387742, 0.4228731957),
  Float2(-0.4407449312, 0.09079595574),
  Float2(-0.06805276192, -0.444824484),
  Float2(0.4453517192, -0.06451237284),
  Float2(0.2562464609, -0.3699158705),
  Float2(0.3278198355, -0.3082761026),
  Float2(-0.4122774207, -0.1803533432),
  Float2(0.3354090914, -0.3000012356),
  Float2(0.446632869, -0.05494615882),
  Float2(-0.1608953296, 0.4202531296),
  Float2(-0.09463954939, 0.4399356268),
  Float2(-0.02637688324, -0.4492262904),
  Float2(0.447102804, -0.05098119915),
  Float2(-0.4365670908, 0.1091291678),
  Float2(-0.3959858651, 0.2137643437),
  Float2(-0.4240048207, -0.1507312575),
  Float2(-0.3882794568, 0.2274622243),
  Float2(-0.4283652566, -0.1378521198),
  Float2(0.3303888091, 0.305521251),
  Float2(0.3321434919, -0.3036127481),
  Float2(-0.413021046, -0.1786438231),
  Float2(0.08403060337, -0.4420846725),
  Float2(-0.3822882919, 0.2373934748),
  Float2(-0.3712395594, -0.2543249683),
  Float2(0.4472363971, -0.04979563372),
  Float2(-0.4466591209, 0.05473234629),
  Float2(0.0486272539, -0.4473649407),
  Float2(-0.4203101295, -0.1607463688),
  Float2(0.2205360833, 0.39225481),
  Float2(-0.3624900666, 0.2666476169),
  Float2(-0.4036086833, -0.1989975647),
  Float2(0.2152727807, 0.3951678503),
  Float2(-0.4359392962, -0.1116106179),
  Float2(0.4178354266, 0.1670735057),
  Float2(0.2007630161, 0.4027334247),
  Float2(-0.07278067175, -0.4440754146),
  Float2(0.3644748615, -0.2639281632),
  Float2(-0.4317451775, 0.126870413),
  Float2(-0.297436456, 0.3376855855),
  Float2(-0.2998672222, 0.3355289094),
  Float2(-0.2673674124, 0.3619594822),
  Float2(0.2808423357, 0.3516071423),
  Float2(0.3498946567, 0.2829730186),
  Float2(-0.2229685561, 0.390877248),
  Float2(0.3305823267, 0.3053118493),
  Float2(-0.2436681211, -0.3783197679),
  Float2(-0.03402776529, 0.4487116125),
  Float2(-0.319358823, 0.3170330301),
  Float2(0.4454633477, -0.06373700535),
  Float2(0.4483504221, 0.03849544189),
  Float2(-0.4427358436, -0.08052932871),
  Float2(0.05452298565, 0.4466847255),
  Float2(-0.2812560807, 0.3512762688),
  Float2(0.1266696921, 0.4318041097),
  Float2(-0.3735981243, 0.2508474468),
  Float2(0.2959708351, -0.3389708908),
  Float2(-0.3714377181, 0.254035473),
  Float2(-0.404467102, -0.1972469604),
  Float2(0.1636165687, -0.419201167),
  Float2(0.3289185495, -0.3071035458),
  Float2(-0.2494824991, -0.3745109914),
  Float2(0.03283133272, 0.4488007393),
  Float2(-0.166306057, -0.4181414777),
  Float2(-0.106833179, 0.4371346153),
  Float2(0.06440260376, -0.4453676062),
  Float2(-0.4483230967, 0.03881238203),
  Float2(-0.421377757, -0.1579265206),
  Float2(0.05097920662, -0.4471030312),
  Float2(0.2050584153, -0.4005634111),
  Float2(0.4178098529, -0.167137449),
  Float2(-0.3565189504, -0.2745801121),
  Float2(0.4478398129, 0.04403977727),
  Float2(-0.3399999602, -0.2947881053),
  Float2(0.3767121994, 0.2461461331),
  Float2(-0.3138934434, 0.3224451987),
  Float2(-0.1462001792, -0.4255884251),
  Float2(0.3970290489, -0.2118205239),
  Float2(0.4459149305, -0.06049689889),
  Float2(-0.4104889426, -0.1843877112),
  Float2(0.1475103971, -0.4251360756),
  Float2(0.09258030352, 0.4403735771),
  Float2(-0.1589664637, -0.4209865359),
  Float2(0.2482445008, 0.3753327428),
  Float2(0.4383624232, -0.1016778537),
  Float2(0.06242802956, 0.4456486745),
  Float2(0.2846591015, -0.3485243118),
  Float2(-0.344202744, -0.2898697484),
  Float2(0.1198188883, -0.4337550392),
  Float2(-0.243590703, 0.3783696201),
  Float2(0.2958191174, -0.3391033025),
  Float2(-0.1164007991, 0.4346847754),
  Float2(0.1274037151, -0.4315881062),
  Float2(0.368047306, 0.2589231171),
  Float2(0.2451436949, 0.3773652989),
  Float2(-0.4314509715, 0.12786735),
];

const List<Float3> cell3d = <Float3>[
  Float3(0.1453787434, -0.4149781685, -0.0956981749),
  Float3(-0.01242829687, -0.1457918398, -0.4255470325),
  Float3(0.2877979582, -0.02606483451, -0.3449535616),
  Float3(-0.07732986802, 0.2377094325, 0.3741848704),
  Float3(0.1107205875, -0.3552302079, -0.2530858567),
  Float3(0.2755209141, 0.2640521179, -0.238463215),
  Float3(0.294168941, 0.1526064594, 0.3044271714),
  Float3(0.4000921098, -0.2034056362, 0.03244149937),
  Float3(-0.1697304074, 0.3970864695, -0.1265461359),
  Float3(-0.1483224484, -0.3859694688, 0.1775613147),
  Float3(0.2623596946, -0.2354852944, 0.2796677792),
  Float3(-0.2709003183, 0.3505271138, -0.07901746678),
  Float3(-0.03516550699, 0.3885234328, 0.2243054374),
  Float3(-0.1267712655, 0.1920044036, 0.3867342179),
  Float3(0.02952021915, 0.4409685861, 0.08470692262),
  Float3(-0.2806854217, -0.266996757, 0.2289725438),
  Float3(-0.171159547, 0.2141185563, 0.3568720405),
  Float3(0.2113227183, 0.3902405947, -0.07453178509),
  Float3(-0.1024352839, 0.2128044156, -0.3830421561),
  Float3(-0.3304249877, -0.1566986703, 0.2622305365),
  Float3(0.2091111325, 0.3133278055, -0.2461670583),
  Float3(0.344678154, -0.1944240454, -0.2142341261),
  Float3(0.1984478035, -0.3214342325, -0.2445373252),
  Float3(-0.2929008603, 0.2262915116, 0.2559320961),
  Float3(-0.1617332831, 0.006314769776, -0.4198838754),
  Float3(-0.3582060271, -0.148303178, -0.2284613961),
  Float3(-0.1852067326, -0.3454119342, -0.2211087107),
  Float3(0.3046301062, 0.1026310383, 0.314908508),
  Float3(-0.03816768434, -0.2551766358, -0.3686842991),
  Float3(-0.4084952196, 0.1805950793, 0.05492788837),
  Float3(-0.02687443361, -0.2749741471, 0.3551999201),
  Float3(-0.03801098351, 0.3277859044, 0.3059600725),
  Float3(0.2371120802, 0.2900386767, -0.2493099024),
  Float3(0.4447660503, 0.03946930643, 0.05590469027),
  Float3(0.01985147278, -0.01503183293, -0.4493105419),
  Float3(0.4274339143, 0.03345994256, -0.1366772882),
  Float3(-0.2072988631, 0.2871414597, -0.2776273824),
  Float3(-0.3791240978, 0.1281177671, 0.2057929936),
  Float3(-0.2098721267, -0.1007087278, -0.3851122467),
  Float3(0.01582798878, 0.4263894424, 0.1429738373),
  Float3(-0.1888129464, -0.3160996813, -0.2587096108),
  Float3(0.1612988974, -0.1974805082, -0.3707885038),
  Float3(-0.08974491322, 0.229148752, -0.3767448739),
  Float3(0.07041229526, 0.4150230285, -0.1590534329),
  Float3(-0.1082925611, -0.1586061639, 0.4069604477),
  Float3(0.2474100658, -0.3309414609, 0.1782302128),
  Float3(-0.1068836661, -0.2701644537, -0.3436379634),
  Float3(0.2396452163, 0.06803600538, -0.3747549496),
  Float3(-0.3063886072, 0.2597428179, 0.2028785103),
  Float3(0.1593342891, -0.3114350249, -0.2830561951),
  Float3(0.2709690528, 0.1412648683, -0.3303331794),
  Float3(-0.1519780427, 0.3623355133, 0.2193527988),
  Float3(0.1699773681, 0.3456012883, 0.2327390037),
  Float3(-0.1986155616, 0.3836276443, -0.1260225743),
  Float3(-0.1887482106, -0.2050154888, -0.353330953),
  Float3(0.2659103394, 0.3015631259, -0.2021172246),
  Float3(-0.08838976154, -0.4288819642, -0.1036702021),
  Float3(-0.04201869311, 0.3099592485, 0.3235115047),
  Float3(-0.3230334656, 0.201549922, -0.2398478873),
  Float3(0.2612720941, 0.2759854499, -0.2409749453),
  Float3(0.385713046, 0.2193460345, 0.07491837764),
  Float3(0.07654967953, 0.3721732183, 0.241095919),
  Float3(0.4317038818, -0.02577753072, 0.1243675091),
  Float3(-0.2890436293, -0.3418179959, -0.04598084447),
  Float3(-0.2201947582, 0.383023377, -0.08548310451),
  Float3(0.4161322773, -0.1669634289, -0.03817251927),
  Float3(0.2204718095, 0.02654238946, -0.391391981),
  Float3(-0.1040307469, 0.3890079625, -0.2008741118),
  Float3(-0.1432122615, 0.371614387, -0.2095065525),
  Float3(0.3978380468, -0.06206669342, 0.2009293758),
  Float3(-0.2599274663, 0.2616724959, -0.2578084893),
  Float3(0.4032618332, -0.1124593585, 0.1650235939),
  Float3(-0.08953470255, -0.3048244735, 0.3186935478),
  Float3(0.118937202, -0.2875221847, 0.325092195),
  Float3(0.02167047076, -0.03284630549, -0.4482761547),
  Float3(-0.3411343612, 0.2500031105, 0.1537068389),
  Float3(0.3162964612, 0.3082064153, -0.08640228117),
  Float3(0.2355138889, -0.3439334267, -0.1695376245),
  Float3(-0.02874541518, -0.3955933019, 0.2125550295),
  Float3(-0.2461455173, 0.02020282325, -0.3761704803),
  Float3(0.04208029445, -0.4470439576, 0.02968078139),
  Float3(0.2727458746, 0.2288471896, -0.2752065618),
  Float3(-0.1347522818, -0.02720848277, -0.4284874806),
  Float3(0.3829624424, 0.1231931484, -0.2016512234),
  Float3(-0.3547613644, 0.1271702173, 0.2459107769),
  Float3(0.2305790207, 0.3063895591, 0.2354968222),
  Float3(-0.08323845599, -0.1922245118, 0.3982726409),
  Float3(0.2993663085, -0.2619918095, -0.2103333191),
  Float3(-0.2154865723, 0.2706747713, 0.287751117),
  Float3(0.01683355354, -0.2680655787, -0.3610505186),
  Float3(0.05240429123, 0.4335128183, -0.1087217856),
  Float3(0.00940104872, -0.4472890582, 0.04841609928),
  Float3(0.3465688735, 0.01141914583, -0.2868093776),
  Float3(-0.3706867948, -0.2551104378, 0.003156692623),
  Float3(0.2741169781, 0.2139972417, -0.2855959784),
  Float3(0.06413433865, 0.1708718512, 0.4113266307),
  Float3(-0.388187972, -0.03973280434, -0.2241236325),
  Float3(0.06419469312, -0.2803682491, 0.3460819069),
  Float3(-0.1986120739, -0.3391173584, 0.2192091725),
  Float3(-0.203203009, -0.3871641506, 0.1063600375),
  Float3(-0.1389736354, -0.2775901578, -0.3257760473),
  Float3(-0.06555641638, 0.342253257, -0.2847192729),
  Float3(-0.2529246486, -0.2904227915, 0.2327739768),
  Float3(0.1444476522, 0.1069184044, 0.4125570634),
  Float3(-0.3643780054, -0.2447099973, -0.09922543227),
  Float3(0.4286142488, -0.1358496089, -0.01829506817),
  Float3(0.165872923, -0.3136808464, -0.2767498872),
  Float3(0.2219610524, -0.3658139958, 0.1393320198),
  Float3(0.04322940318, -0.3832730794, 0.2318037215),
  Float3(-0.08481269795, -0.4404869674, -0.03574965489),
  Float3(0.1822082075, -0.3953259299, 0.1140946023),
  Float3(-0.3269323334, 0.3036542563, 0.05838957105),
  Float3(-0.4080485344, 0.04227858267, -0.184956522),
  Float3(0.2676025294, -0.01299671652, 0.36155217),
  Float3(0.3024892441, -0.1009990293, -0.3174892964),
  Float3(0.1448494052, 0.425921681, -0.0104580805),
  Float3(0.4198402157, 0.08062320474, 0.1404780841),
  Float3(-0.3008872161, -0.333040905, -0.03241355801),
  Float3(0.3639310428, -0.1291284382, -0.2310412139),
  Float3(0.3295806598, 0.0184175994, -0.3058388149),
  Float3(0.2776259487, -0.2974929052, -0.1921504723),
  Float3(0.4149000507, -0.144793182, -0.09691688386),
  Float3(0.145016715, -0.0398992945, 0.4241205002),
  Float3(0.09299023471, -0.299732164, -0.3225111565),
  Float3(0.1028907093, -0.361266869, 0.247789732),
  Float3(0.2683057049, -0.07076041213, -0.3542668666),
  Float3(-0.4227307273, -0.07933161816, -0.1323073187),
  Float3(-0.1781224702, 0.1806857196, -0.3716517945),
  Float3(0.4390788626, -0.02841848598, -0.09435116353),
  Float3(0.2972583585, 0.2382799621, -0.2394997452),
  Float3(-0.1707002821, 0.2215845691, 0.3525077196),
  Float3(0.3806686614, 0.1471852559, -0.1895464869),
  Float3(-0.1751445661, -0.274887877, 0.3102596268),
  Float3(-0.2227237566, -0.2316778837, 0.3149912482),
  Float3(0.1369633021, 0.1341343041, -0.4071228836),
  Float3(-0.3529503428, -0.2472893463, -0.129514612),
  Float3(-0.2590744185, -0.2985577559, -0.2150435121),
  Float3(-0.3784019401, 0.2199816631, -0.1044989934),
  Float3(-0.05635805671, 0.1485737441, 0.4210102279),
  Float3(0.3251428613, 0.09666046873, -0.2957006485),
  Float3(-0.4190995804, 0.1406751354, -0.08405978803),
  Float3(-0.3253150961, -0.3080335042, -0.04225456877),
  Float3(0.2857945863, -0.05796152095, 0.3427271751),
  Float3(-0.2733604046, 0.1973770973, -0.2980207554),
  Float3(0.219003657, 0.2410037886, -0.3105713639),
  Float3(0.3182767252, -0.271342949, 0.1660509868),
  Float3(-0.03222023115, -0.3331161506, -0.300824678),
  Float3(-0.3087780231, 0.1992794134, -0.2596995338),
  Float3(-0.06487611647, -0.4311322747, 0.1114273361),
  Float3(0.3921171432, -0.06294284106, -0.2116183942),
  Float3(-0.1606404506, -0.358928121, -0.2187812825),
  Float3(-0.03767771199, -0.2290351443, 0.3855169162),
  Float3(0.1394866832, -0.3602213994, 0.2308332918),
  Float3(-0.4345093872, 0.005751117145, 0.1169124335),
  Float3(-0.1044637494, 0.4168128432, -0.1336202785),
  Float3(0.2658727501, 0.2551943237, 0.2582393035),
  Float3(0.2051461999, 0.1975390727, 0.3484154868),
  Float3(-0.266085566, 0.23483312, 0.2766800993),
  Float3(0.07849405464, -0.3300346342, -0.2956616708),
  Float3(-0.2160686338, 0.05376451292, -0.3910546287),
  Float3(-0.185779186, 0.2148499206, 0.3490352499),
  Float3(0.02492421743, -0.3229954284, -0.3123343347),
  Float3(-0.120167831, 0.4017266681, 0.1633259825),
  Float3(-0.02160084693, -0.06885389554, 0.4441762538),
  Float3(0.2597670064, 0.3096300784, 0.1978643903),
  Float3(-0.1611553854, -0.09823036005, 0.4085091653),
  Float3(-0.3278896792, 0.1461670309, 0.2713366126),
  Float3(0.2822734956, 0.03754421121, -0.3484423997),
  Float3(0.03169341113, 0.347405252, -0.2842624114),
  Float3(0.2202613604, -0.3460788041, -0.1849713341),
  Float3(0.2933396046, 0.3031973659, 0.1565989581),
  Float3(-0.3194922995, 0.2453752201, -0.200538455),
  Float3(-0.3441586045, -0.1698856132, -0.2349334659),
  Float3(0.2703645948, -0.3574277231, 0.04060059933),
  Float3(0.2298568861, 0.3744156221, 0.0973588921),
  Float3(0.09326603877, -0.3170108894, 0.3054595587),
  Float3(-0.1116165319, -0.2985018719, 0.3177080142),
  Float3(0.2172907365, -0.3460005203, -0.1885958001),
  Float3(0.1991339479, 0.3820341668, -0.1299829458),
  Float3(-0.0541918155, -0.2103145071, 0.39412061),
  Float3(0.08871336998, 0.2012117383, 0.3926114802),
  Float3(0.2787673278, 0.3505404674, 0.04370535101),
  Float3(-0.322166438, 0.3067213525, 0.06804996813),
  Float3(-0.4277366384, 0.132066775, 0.04582286686),
  Float3(0.240131882, -0.1612516055, 0.344723946),
  Float3(0.1448607981, -0.2387819045, 0.3528435224),
  Float3(-0.3837065682, -0.2206398454, 0.08116235683),
  Float3(-0.4382627882, -0.09082753406, -0.04664855374),
  Float3(-0.37728353, 0.05445141085, 0.2391488697),
  Float3(0.1259579313, 0.348394558, 0.2554522098),
  Float3(-0.1406285511, -0.270877371, -0.3306796947),
  Float3(-0.1580694418, 0.4162931958, -0.06491553533),
  Float3(0.2477612106, -0.2927867412, -0.2353514536),
  Float3(0.2916132853, 0.3312535401, 0.08793624968),
  Float3(0.07365265219, -0.1666159848, 0.411478311),
  Float3(-0.26126526, -0.2422237692, 0.2748965434),
  Float3(-0.3721862032, 0.252790166, 0.008634938242),
  Float3(-0.3691191571, -0.255281188, 0.03290232422),
  Float3(0.2278441737, -0.3358364886, 0.1944244981),
  Float3(0.363398169, -0.2310190248, 0.1306597909),
  Float3(-0.304231482, -0.2698452035, 0.1926830856),
  Float3(-0.3199312232, 0.316332536, -0.008816977938),
  Float3(0.2874852279, 0.1642275508, -0.304764754),
  Float3(-0.1451096801, 0.3277541114, -0.2720669462),
  Float3(0.3220090754, 0.0511344108, 0.3101538769),
  Float3(-0.1247400865, -0.04333605335, -0.4301882115),
  Float3(-0.2829555867, -0.3056190617, -0.1703910946),
  Float3(0.1069384374, 0.3491024667, -0.2630430352),
  Float3(-0.1420661144, -0.3055376754, -0.2982682484),
  Float3(-0.250548338, 0.3156466809, -0.2002316239),
  Float3(0.3265787872, 0.1871229129, 0.2466400438),
  Float3(0.07646097258, -0.3026690852, 0.324106687),
  Float3(0.3451771584, 0.2757120714, -0.0856480183),
  Float3(0.298137964, 0.2852657134, 0.179547284),
  Float3(0.2812250376, 0.3466716415, 0.05684409612),
  Float3(0.4390345476, -0.09790429955, -0.01278335452),
  Float3(0.2148373234, 0.1850172527, 0.3494474791),
  Float3(0.2595421179, -0.07946825393, 0.3589187731),
  Float3(0.3182823114, -0.307355516, -0.08203022006),
  Float3(-0.4089859285, -0.04647718411, 0.1818526372),
  Float3(-0.2826749061, 0.07417482322, 0.3421885344),
  Float3(0.3483864637, 0.225442246, -0.1740766085),
  Float3(-0.3226415069, -0.1420585388, -0.2796816575),
  Float3(0.4330734858, -0.118868561, -0.02859407492),
  Float3(-0.08717822568, -0.3909896417, -0.2050050172),
  Float3(-0.2149678299, 0.3939973956, -0.03247898316),
  Float3(-0.2687330705, 0.322686276, -0.1617284888),
  Float3(0.2105665099, -0.1961317136, -0.3459683451),
  Float3(0.4361845915, -0.1105517485, 0.004616608544),
  Float3(0.05333333359, -0.313639498, -0.3182543336),
  Float3(-0.05986216652, 0.1361029153, -0.4247264031),
  Float3(0.3664988455, 0.2550543014, -0.05590974511),
  Float3(-0.2341015558, -0.182405731, 0.3382670703),
  Float3(-0.04730947785, -0.4222150243, -0.1483114513),
  Float3(-0.2391566239, -0.2577696514, -0.2808182972),
  Float3(-0.1242081035, 0.4256953395, -0.07652336246),
  Float3(0.2614832715, -0.3650179274, 0.02980623099),
  Float3(-0.2728794681, -0.3499628774, 0.07458404908),
  Float3(0.007892900508, -0.1672771315, 0.4176793787),
  Float3(-0.01730330376, 0.2978486637, -0.3368779738),
  Float3(0.2054835762, -0.3252600376, -0.2334146693),
  Float3(-0.3231994983, 0.1564282844, -0.2712420987),
  Float3(-0.2669545963, 0.2599343665, -0.2523278991),
  Float3(-0.05554372779, 0.3170813944, -0.3144428146),
  Float3(-0.2083935713, -0.310922837, -0.2497981362),
  Float3(0.06989323478, -0.3156141536, 0.3130537363),
  Float3(0.3847566193, -0.1605309138, -0.1693876312),
  Float3(-0.3026215288, -0.3001537679, -0.1443188342),
  Float3(0.3450735512, 0.08611519592, 0.2756962409),
  Float3(0.1814473292, -0.2788782453, -0.3029914042),
  Float3(-0.03855010448, 0.09795110726, 0.4375151083),
  Float3(0.3533670318, 0.2665752752, 0.08105160988),
  Float3(-0.007945601311, 0.140359426, -0.4274764309),
  Float3(0.4063099273, -0.1491768253, -0.1231199324),
  Float3(-0.2016773589, 0.008816271194, -0.4021797064),
  Float3(-0.07527055435, -0.425643481, -0.1251477955),
];
