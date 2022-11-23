//
// Tomás Oliveira e Silva, AED, November 2021
//
// Generic queue (First In First Out) implementation based on an linked list
//

#ifndef _AED_lQueue_
#define _AED_lQueue_

#include "sList.h"
#include <cassert>


template <typename T>
class lQueue
{
  private:
	int max_size;
	sList<T> *list;      // the queue data (stored in an array)
  public:
	lQueue(void)
	{
	  	max_size = 1000000;
	  	list = new sList<T>();
	}
	~lQueue(void)
	{
	  	delete list;
	  	max_size = 0;
	  	
	}
	void clear(void)
	{
		list->move_to_head();
		for(int i = 0; i < list->size(); i++){
			list->remove();
		}
	}
	int size(void) const
	{
	  	return list->size();
	}
	int is_full(void) const
	{
	  	return (list->size() == max_size) ? 1 : 0;
	}
	int is_empty(void) const
	{
	  	return (list->size() == 0) ? 1 : 0;
	}
	void enqueue(T &v)
	{
		assert(list->size() < max_size);
		list->insert_after_tail(v);
	}
	T dequeue(void)
	{
		assert(list->size() > 0);
		list->move_to_head();
		T v = list->value();
		list->remove_head();
		return v;
	}
	T peek(void)
	{
		list->move_to_head();
		return list->value();
	}
};

#endif
