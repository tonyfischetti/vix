// js, typescript, ts, abstract classes


type SQLQuery = string;
type SQLFragment = string;


abstract class DialectAdapter {
  readonly tableName: string;

  constructor(tableName: string) {
    this.tableName = tableName;
  }

  abstract escapeID(s: string): string;

  public getFromClause(): SQLFragment {
    return `FROM ${this.escapeID(this.tableName)}`;
  }

  public toSQL(): SQLQuery {
    const fromClause = this.getFromClause();
    return fromClause;
  }
}


class SQLiteAdapter extends DialectAdapter {
  public escapeID(s: string): string {
    return '`' + s + '`';
  }
}

class PostgresAdapter extends DialectAdapter {
  public escapeID(s: string): string {
    return `"${s}"`;
  }
}

const adapter1 = new SQLiteAdapter('main');
const adapter2 = new PostgresAdapter('main');

adapter1.toSQL();     // FROM `main`
adapter2.toSQL();     // FROM "main"

