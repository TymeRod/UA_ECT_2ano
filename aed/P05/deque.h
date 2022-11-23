//
// Tomás Oliveira e Silva, AED, November 2021
//
// Generic deque implementation based on a circular buffer
//

#ifndef _AED_deque_
#define _AED_deque_

#include <cassert>
#include "sList.h"

template <typename T>
class deque
{
  private:

	int Max_size; // maximum deque size
	sList<T> *list;      // the deque data (stored in an array)

  public:
	deque(int max_size = 100)
	{
		Max_size = max_size;
		list = new sList<T>();
	}
	~deque(void)
	{
		delete list;
		Max_size = 0;
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
		return (list->size() == Max_size) ? 1 : 0;
	}
	int is_empty(void) const
	{
		return (list->size() == 0) ? 1 : 0;
	}
	void insert_at_head(T v)
	{
		assert(list->size() < Max_size);
		list->insert_before_head(v);
	}
	T remove_head(void)
	{
		assert(list->size() > 0);
		list->move_to_head();
		T v = list->value();
		list->remove();
		return v;
	}
	T peek_head(void)
	{
		assert(list->size() > 0);
		list->move_to_head();
		T v = list->value();
		return v;
	}
	void insert_at_tail(T v)
	{
		assert(list->size() < Max_size);
		list->insert_after_tail(v);
	}
	T remove_tail(void)
	{
		assert(list->size() > 0);
		list->move_to_tail();
		T v = list->value();
		list->remove();
		return v;
	}
	T peek_tail(void)
	{
		assert(list->size() > 0);
		list->move_to_tail();
		T v = list->value();
		return v;
	}
};

#endif
