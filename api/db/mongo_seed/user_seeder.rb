
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
                    class: ["1", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img1.jpg", 
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
                    class: ["1", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img2.jpg", 
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
                    class: ["1", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img3.jpg", 
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
                    class: ["1", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img4.jpg", 
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
                    name: "先生100",
                    school: "小学校",
                    grade: "1",
                    schoolid: "",
                    class: ["1", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img5.jpg", 
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
                    class: ["1", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img6.jpg", 
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
                    class: ["1", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img7.jpg", 
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
                    class: ["1", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img8.jpg", 
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
                    name: "先生200",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: ["1", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img9.jpg", 
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
                    class: ["2", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img10.jpg", 
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
                    class: ["2", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img11.jpg", 
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
                    class: ["2", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img12.jpg", 
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
                    class: ["2", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img13.jpg", 
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
                    name: "先生300",
                    school: "小学校",
                    grade: "2",
                    schoolid: "",
                    class: ["2", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img14.jpg", 
                    role: "teacher",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "dp311": {
                    userid: "dp311",
                    name: "学習者311",
                    school: "小学校",
                    grade: "3",
                    schoolid: "",
                    class: ["3", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img14.jpg", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "dp411": {
                    userid: "dp411",
                    name: "学習者411",
                    school: "小学校",
                    grade: "4",
                    schoolid: "",
                    class: ["4", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img14.jpg", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "dp511": {
                    userid: "dp511",
                    name: "学習者511",
                    school: "小学校",
                    grade: "5",
                    schoolid: "",
                    class: ["5", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img14.jpg", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "dp611": {
                    userid: "dp611",
                    name: "学習者611",
                    school: "小学校",
                    grade: "6",
                    schoolid: "",
                    class: ["6", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img14.jpg", 
                    role: "student",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "dp400t": {
                    userid: "dp400t",
                    name: "先生400",
                    school: "小学校",
                    grade: "4",
                    schoolid: "",
                    class: ["4", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img14.jpg", 
                    role: "teacher",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "dp500t": {
                    userid: "dp500t",
                    name: "先生500",
                    school: "小学校",
                    grade: "5",
                    schoolid: "",
                    class: ["5", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img14.jpg", 
                    role: "teacher",
                    password: testpass,
                    crownNum:{ 
                      gold: 0,
                      silver: 0, 
                      bronze: 0 
                    }
                  },
                  "dp600t": {
                    userid: "dp600t",
                    name: "先生600",
                    school: "小学校",
                    grade: "6",
                    schoolid: "",
                    class: ["6", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/profileicon/img14.jpg", 
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
