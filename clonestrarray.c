/* libvstring/clonestrarray.c */

#include "libvstring.h"
#include <proto/exec.h>


STRPTR* CloneStrArray(STRPTR *array)
{
	STRPTR *p0, *p1,  *copy;

	/* Allocate array. */

	if (copy = internal_alloc((StrArrayLen(array) + sizeof(char)) * sizeof(STRPTR*)))
	{
		/* Copy entries. */

		for (p0 = array, p1 = copy; *p0; p0++, p1++)
		{
			if (!(*p1 = StrNew(*p0)))
			{
				FreeStrArray(copy);
				copy = NULL;
				break;
			}
		}

		*p1 = NULL;
	}

	return copy;
}

