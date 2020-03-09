class Task{

  String text = "";
  bool completed = false;

  Task(String text){

    this.text = text;

  }

  setCompleted(){

    this.completed = true;

  }

  unComplete() {

    this.completed = false;

  }

}