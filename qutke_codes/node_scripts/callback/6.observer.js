class Subject {
  constructor(name) {
    this.name = name;
    this.satus = "nice";
    this.arr = [];
  }
  attach(observer) {
    this.arr.push(observer);
  }
  Set_status(newstatus) {
    this.satus = newstatus;
    this.arr.forEach((ob) => ob.update(newstatus));
  }
}

class Observer {
  constructor(name) {
    this.name = name;
  }

  update(newstatus) {
    console.log(`${this.name} ok now I  konw your status is ${newstatus}`);
  }
}

let ob1 = new Observer("ob1");

let ob2 = new Observer("ob2");

let sub1 = new Subject("sub1");

sub1.attach(ob1);
sub1.attach(ob2);
sub1.Set_status("不 nice");
