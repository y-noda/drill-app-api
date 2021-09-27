
testpass = Digest::MD5.hexdigest("testpass")

@answer = User.create(
                key: 'users', 
                save_data: {
                  "db111": {
                    userid: "db111",
                    name: "学習者101",
                    school: "小学校",
                    grade: "1",
                    schoolid: "",
                    class: [1, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db112": {
                    userid: "db112",
                    name: "学習者102",
                    school: "小学校",
                    grade: "1",
                    schoolid: "",
                    class: [1, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db113": {
                    userid: "db113",
                    name: "学習者103",
                    school: "小学校",
                    grade: "1",
                    schoolid: "",
                    class: [1, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db114": {
                    userid: "db114",
                    name: "学習者104",
                    school: "小学校",
                    grade: "1",
                    schoolid: "",
                    class: [1, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db110t": {
                    userid: "db110t",
                    name: "管理者100",
                    school: "小学校",
                    grade: "1",
                    schoolid: "",
                    class: [1, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db211": {
                    userid: "db211",
                    name: "学習者201",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: [1, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db212": {
                    userid: "db212",
                    name: "学習者202",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: [1, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db213": {
                    userid: "db213",
                    name: "学習者203",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: [1, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db210t": {
                    userid: "db210t",
                    name: "管理者200",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: [1, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "teacher",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db221": {
                    userid: "db221",
                    name: "学習者301",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: [2, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db222": {
                    userid: "db222",
                    name: "学習者302",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: [2, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db223": {
                    userid: "db223",
                    name: "学習者303",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: [2, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db224": {
                    userid: "db224",
                    name: "学習者304",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: [2, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "db220t": {
                    userid: "db220t",
                    name: "管理者300",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: [2, "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    role: "teacher",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  }
                }
              )
