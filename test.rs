fn main() {
    // generate task scheduler
    let mut sched = TaskScheduler::new();
    // create a task
    let task = sched.create_task(|| {
        println!("Hello, world!");
    });
}