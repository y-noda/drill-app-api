
testpass = Digest::MD5.hexdigest("testpass")

@answer = User.create(
                key: 'users', 
                save_data: {
                  "dp111": {
                    userid: "dp111",
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
                  "dp112": {
                    userid: "dp112",
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
                  "dp113": {
                    userid: "dp113",
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
                  "dp114": {
                    userid: "dp114",
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
                  "dp110t": {
                    userid: "dp110t",
                    name: "管理者100",
                    school: "小学校",
                    grade: "1",
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
                  "dp211": {
                    userid: "dp211",
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
                  "dp212": {
                    userid: "dp212",
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
                  "dp213": {
                    userid: "dp213",
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
                  "dp210t": {
                    userid: "dp210t",
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
                  "dp221": {
                    userid: "dp221",
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
                  "dp222": {
                    userid: "dp222",
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
                  "dp223": {
                    userid: "dp223",
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
                  "dp224": {
                    userid: "dp224",
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
                  "dp220t": {
                    userid: "dp220t",
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
