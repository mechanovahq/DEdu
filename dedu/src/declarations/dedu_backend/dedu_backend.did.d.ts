import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface user { 'name' : string }
export type userId = number;
export interface _SERVICE {
  'create' : ActorMethod<[user], userId>,
  'delete' : ActorMethod<[userId], boolean>,
  'read' : ActorMethod<[userId], [] | [user]>,
  'update' : ActorMethod<[userId, user], boolean>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
