namespace TestEditor.Contents
{
	internal interface IEntitySerializer<in T, out S>
		where T : notnull
		where S : notnull, ISerializedEntity<T>
	{
		S Serialize(T entity);
	}
}
