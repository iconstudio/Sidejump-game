namespace TestEditor.Contents
{
	internal interface IEntitySerializer<in T, out S>
		where T : notnull
		where S : notnull, IMapSerial<T>
	{
		S Serialize(T entity);
	}
}
