export const idlFactory = ({ IDL }) => {
  const user = IDL.Record({ 'name' : IDL.Text });
  const userId = IDL.Nat32;
  return IDL.Service({
    'create' : IDL.Func([user], [userId], []),
    'delete' : IDL.Func([userId], [IDL.Bool], []),
    'read' : IDL.Func([userId], [IDL.Opt(user)], ['query']),
    'update' : IDL.Func([userId, user], [IDL.Bool], []),
  });
};
export const init = ({ IDL }) => { return []; };
