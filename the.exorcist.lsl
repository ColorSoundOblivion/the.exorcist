/*
 * the exorcist v1.0 ( https://github.com/colorsoundoblivion/the.exorcist/ )
 * Copyright (C) 2020 Felix (colorsoundoblivion)
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
 * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
//////////////////////////////////////////////<-- 110 width -->//////////////////////////////////////////////

integer AttachedCount;
integer TeleportCount;
integer Elapsed;
string Owner;

default
{
    state_entry()
    {
        Owner = llGetOwner();
        Elapsed = 0;
        AttachedCount = llGetListLength(llGetAttachedList(Owner));
        TeleportCount = AttachedCount;
        llSetLinkPrimitiveParamsFast(1, [PRIM_COLOR, ALL_SIDES, <0.69, 1.0, 0.85>, 1]);
        llSetLinkPrimitiveParamsFast(2, [PRIM_TEXT, " \nlookin good!\n ", <1,1,1>, 1]);
        llSetTimerEvent(1);
    }
    on_rez(integer start_param) { llResetScript(); }
    touch_start(integer total_number) { llResetScript(); }

    changed(integer change)
    {
        if (change & CHANGED_TELEPORT)
        {
            TeleportCount = llGetListLength(llGetAttachedList(Owner));
            if (TeleportCount < AttachedCount) {
                llSetLinkPrimitiveParamsFast(1, [PRIM_COLOR, ALL_SIDES, <1.0, 0.0, 0.5>, 1]);
                llSetLinkPrimitiveParamsFast(2, [PRIM_TEXT, "ghosted :(\npress Alt+Shift+R\nthen click me to reset!", <1,1,1>, 1]);
                llSetTimerEvent(0);
            }
        }
    }

    timer()
    {
        if (Elapsed == 10) {
            Elapsed = 0;
            AttachedCount = llGetListLength(llGetAttachedList(Owner));
        }
    }
}

