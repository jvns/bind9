/*
 * Copyright (C) 1999  Internet Software Consortium.
 * 
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS" AND INTERNET SOFTWARE CONSORTIUM DISCLAIMS
 * ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL INTERNET SOFTWARE
 * CONSORTIUM BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 * DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 * PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
 * ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
 * SOFTWARE.
 */

#ifndef DNS_EVENTS_H
#define DNS_EVENTS_H 1

#include <isc/eventclass.h>
#include <isc/lang.h>

/*
 * Registry of DNS event numbers.
 */

ISC_LANG_BEGINDECLS

#define DNS_EVENT_FETCH				(ISC_EVENTCLASS_DNS + 0)
#define DNS_EVENT_FETCHDONE			(ISC_EVENTCLASS_DNS + 1)
#define DNS_EVENT_FIND				(ISC_EVENTCLASS_DNS + 2)
#define DNS_EVENT_FINDDONE			(ISC_EVENTCLASS_DNS + 3)
#define DNS_EVENT_QUERY				(ISC_EVENTCLASS_DNS + 4)
#define DNS_EVENT_QUERYDONE			(ISC_EVENTCLASS_DNS + 5)
#define DNS_EVENT_DISPATCH			(ISC_EVENTCLASS_DNS + 6)
#define DNS_EVENT_TCPMSG			(ISC_EVENTCLASS_DNS + 7)

#define DNS_EVENT_FIRSTEVENT			(ISC_EVENTCLASS_DNS + 0)
#define DNS_EVENT_LASTEVENT			(ISC_EVENTCLASS_DNS + 65535)

ISC_LANG_ENDDECLS

#endif /* DNS_EVENTS_H */
