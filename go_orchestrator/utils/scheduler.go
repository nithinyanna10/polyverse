package utils

import "time"

type Scheduler struct {
	tasks chan func()
}

func NewScheduler() *Scheduler {
	s := &Scheduler{
		tasks: make(chan func(), 100),
	}
	go s.run()
	return s
}

func (s *Scheduler) Schedule(task func(), delay time.Duration) {
	go func() {
		time.Sleep(delay)
		s.tasks <- task
	}()
}

func (s *Scheduler) run() {
	for task := range s.tasks {
		task()
	}
}

