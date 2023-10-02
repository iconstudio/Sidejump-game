namespace TestEditor.Contents
{
	internal interface IEntitiesSerializer<in T, out S> : IEntitySerializer<T, S>
		where T : notnull
		where S : notnull, IMapSerial<T>
	{
		IReadOnlyList<S> Serialize(IEnumerable<T> entity);
	}
}
