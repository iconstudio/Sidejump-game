namespace TestEditor.Contents
{
	internal interface IMapEntity : IMapObject
	{
	}
	internal interface IMapEntity<out S> : IMapObject, IMapEntity
		where S : notnull, IMapSerial
	{
		S Serialize();
	}
	internal interface IMapEntity<out S, in T0>
		: IMapObject, IMapEntity
		where S : notnull, IMapSerial
	{
		S Serialize(T0 arg0);
	}
	internal interface IMapEntity<out S, in T0, in T1>
		: IMapObject, IMapEntity
		where S : notnull, IMapSerial
	{
		S Serialize(T0 arg0, T1 arg1);
	}
	internal interface IMapEntity<out S, in T0, in T1, in T2>
		: IMapObject, IMapEntity
		where S : notnull, IMapSerial
	{
		S Serialize(T0 arg0, T1 arg1, T2 arg2);
	}
	internal interface IMapEntity<out S, in T0, in T1, in T2, in T3>
		: IMapObject, IMapEntity
		where S : notnull, IMapSerial
	{
		S Serialize(T0 arg0, T1 arg1, T2 arg2, T3 arg3);
	}
	internal interface IMapEntity<out S, in T0, in T1, in T2, in T3, in T4>
		: IMapObject, IMapEntity
		where S : notnull, IMapSerial
	{
		S Serialize(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4);
	}
	internal interface IMapEntity<out S, in T0, in T1, in T2, in T3, in T4, in T5>
		: IMapObject, IMapEntity
		where S : notnull, IMapSerial
	{
		S Serialize(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5);
	}
	internal interface IMapEntity<out S, in T0, in T1, in T2, in T3, in T4, in T5, in T6>
		: IMapObject, IMapEntity
		where S : notnull, IMapSerial
	{
		S Serialize(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6);
	}
}
