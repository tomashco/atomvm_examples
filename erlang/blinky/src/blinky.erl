%
% This file is part of AtomVM.
%
% Copyright 2018-2020 Davide Bettio <davide@uninstall.it>
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%    http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%
% SPDX-License-Identifier: Apache-2.0 OR LGPL-2.1-or-later
%

-module(blinky).
-export([start/0]).

-define(PIN, 2).

start() ->
    case verify_platform(atomvm:platform()) of
        ok ->
            gpio:set_pin_mode(?PIN, output),
            loop(?PIN, low);
        Error ->
            Error
    end.

loop(Pin, Level) ->
    io:format("Setting pin ~p ~p~n", [Pin, Level]),
    gpio:digital_write(Pin, Level),
    timer:sleep(1000),
    loop(
        Pin,
        case Level of
            low -> high;
            high -> low
        end
    ).

verify_platform(esp32) ->
    ok;
verify_platform(stm32) ->
    ok;
verify_platform(Platform) ->
    {error, {unsupported_platform, Platform}}.
