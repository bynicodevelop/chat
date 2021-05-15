const faker = require("faker");
const dayjs = require("dayjs");

const random = (min, max) => Math.floor(Math.random() * (max - min)) + min;

const generateDate = (time, interval = "hours") => {
  const randomDay = Math.floor(Math.random() * time) + 1;

  return dayjs().subtract(randomDay, interval).unix();
};

exports.users = [
  {
    uid: "ROLBPwOHqFr73XFh3GWB8nvPgzmv",
    email: "john@domain.tld",
    password: "123456",
    displayName: "John doe",
    photoURL:
      "https://images.pexels.com/photos/1317712/pexels-photo-1317712.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    membersId: ["YFFiR8w9YhfyDGl33yfyRfTYEOq7", "vAw9DqEPHnT2hz0EZ7wNOQC7FtyU"],
  },
  {
    uid: "YFFiR8w9YhfyDGl33yfyRfTYEOq7",
    email: "jane@domain.tld",
    password: "123456",
    displayName: "Jane",
    photoURL:
      "https://images.pexels.com/photos/1520760/pexels-photo-1520760.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    membersId: ["fQY7y3z7sziXj0R4J3O6g2HJqtgX", "wkGf88oil7jYhnOxQ7MadnlJp4og"],
  },
  {
    uid: "fQY7y3z7sziXj0R4J3O6g2HJqtgX",
    email: "boby@domain.tld",
    password: "123456",
    displayName: "Boby",
    photoURL:
      "https://images.pexels.com/photos/4655426/pexels-photo-4655426.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    membersId: ["wkGf88oil7jYhnOxQ7MadnlJp4og"],
  },
  {
    uid: "vAw9DqEPHnT2hz0EZ7wNOQC7FtyU",
    email: "stan@domain.tld",
    password: "123456",
    displayName: "Stan Ley",
    photoURL:
      "https://images.pexels.com/photos/3750717/pexels-photo-3750717.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    membersId: ["YFFiR8w9YhfyDGl33yfyRfTYEOq7"],
  },
  {
    uid: "wkGf88oil7jYhnOxQ7MadnlJp4og",
    email: "roby@domain.tld",
    password: "123456",
    displayName: "Roby Will Iams",
    photoURL:
      "https://images.pexels.com/photos/3058391/pexels-photo-3058391.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    membersId: ["vAw9DqEPHnT2hz0EZ7wNOQC7FtyU"],
  },
];

exports.groups = (nGroups, nMessages = 100) => {
  return Array.from(Array(nGroups), (_, index) => {
    const listMessage = messages(random(1, nMessages));
    return {
      messages: listMessage,
      createdAt: generateDate(50, "days"),
    };
  });
};

const messages = (n) => {
  return Array.from(Array(n), (_, index) => {
    return {
      content: faker.lorem.sentences(random(1, 4)),
      sentAt: generateDate(10),
    };
  });
};
